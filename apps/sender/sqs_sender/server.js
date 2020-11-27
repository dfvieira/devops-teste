var express = require('express'),
    bodyParser = require('body-parser'),
    AWS = require('aws-sdk');;

var app = express();

AWS.config.update({region: process.env.AWS_DEFAULT_REGION});
var sqs = new AWS.SQS({apiVersion: '2012-11-05'});

// body-parser
app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());

var port = 8001;

app.listen(port);

console.log('Servidor para envio de mensagems ao AWS SQS');

app.get('/', function(req, res){
    res.send('Servidor para envio de mensagems ao AWS SQS');
});

// POST(create)
app.post('/api', function(req, res){
    var dados = {
      DelaySeconds: 10,
      MessageAttributes: {
        "Nome": {
          DataType: "String",
          StringValue: req.body['Nome'],
        },
        "Sugestao": {
        DataType: "String",
        StringValue: req.body['Sugestao'],
        }
     },
     MessageBody: "Envio de Sugestão.",
        QueueUrl: process.env.SQS_URL
    };
    res.send (dados),
    sqs.sendMessage(dados, function(err, data) {
        if (err) {
          console.log("Erro ao enviar", err);
        } else {
          console.log("Sucesso, mensagem enviada", data.MessageId);
        }
      });
});