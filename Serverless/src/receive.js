console.log('Loading function');

var AWS = require('aws-sdk');
var sqs = new AWS.SQS({ region: 'us-east-1' });

exports.handler = async (event, context, callback) => {

  for (var record of event.Records) {
    
    console.log('payload:', record.body);

    var deleteParams = { QueueUrl: process.env.sqsUrl, ReceiptHandle: record.receiptHandle };

    await sqs.deleteMessage(deleteParams, function (err, data) {
      
      if (err) console.log("Delete Error", err);  
      else console.log("Message Deleted", data); 
      return data;
      
    }).promise().then((result) => console.log('Message deleted', result));
  }

  const response = {
    statusCode: 200,
    body: JSON.stringify({ message: 'Message received and deleted' })
  };

  callback(null, response);
};
