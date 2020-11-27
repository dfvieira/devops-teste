const { Consumer } = require('sqs-consumer');
const AWS = require('aws-sdk');
var MongoClient = require('mongodb').MongoClient;
var url = process.env.MONGO_URL;
 
AWS.config.update({region: process.env.AWS_DEFAULT_REGION});
 
const app = Consumer.create({
  queueUrl: process.env.SQS_URL,
  handleMessage: async (message) => {
    


MongoClient.connect(url, function(err, db) {
  if (err) throw err;
  var dbo = db.db(process.env.MONGO_DB);
  
  dbo.collection(process.env.MONGO_COLLECTION).insertOne(message, function(err, res) {
    if (err) throw err;
    console.log("Documento adicionado");
    db.close();
  });
})	
  },
  sqs: new AWS.SQS()
});
 
app.on('error', (err) => {
  console.error(err.message);
});
 
app.on('processing_error', (err) => {
  console.error(err.message);
});

app.on('timeout_error', (err) => {
 console.error(err.message);
});
 
app.start();