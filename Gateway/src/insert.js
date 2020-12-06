console.log('Loading function');

var AWS = require('aws-sdk');
var queueUrl = 'https://sqs.us-east-1.amazonaws.com/085297972612/SQS-principal-dev';
var sqs = new AWS.SQS({region:'eu-east-1'}); 

exports.handler = async (event, context, callback) => {
  
  var sqsMessageId = null;
  
  var params = { MessageBody: event.body, QueueUrl: queueUrl };

  await sqs
    .sendMessage(params, (err, data) => console.log(data.MessageId ? data.MessageId : err))
    .promise()
    .then((result)=> sqsMessageId = result.MessageId);
  
  const response = {
    statusCode: 200,
    body: JSON.stringify({
      message: 'Go Serverless v1.0! Your function executed successfully!',
      payload: event.body,
      sqsMessageId,
      joke: 'Imagina você lá na igreja do padre Tito... você ajoelhado e o padre Tito orando.'
    }),
  };
  
  callback(null, response);
};
