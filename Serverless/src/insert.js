console.log('Loading function');

var AWS = require('aws-sdk');
var sqs = new AWS.SQS({region:'us-east-1'}); 

exports.handler = async (event, context, callback) => {
  
  var sqsMessageId = null;
  
  var params = { MessageBody: event.body, QueueUrl: process.env.sqsUrl };

  await sqs
    .sendMessage(params, (err, data) => console.log(data.MessageId ? data.MessageId : err))
    .promise()
    .then((result)=> sqsMessageId = result.MessageId);
  
  const response = {
    statusCode: 200,
    body: JSON.stringify({
      message: 'Payload registered!',
      payload: event.body,
      sqsMessageId
    }),
  };
  
  callback(null, response);
};
