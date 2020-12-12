console.log('Loading function');

var AWS = require('aws-sdk');
var sns = new AWS.SNS({ region: 'us-east-1' });

exports.handler = async (event, context, callback) => {

  for (var record of event.Records) {

    var params = { Message: record.body, TopicArn: process.env.snsArn };

    console.log('Send to SNS:', params);
        
    await sns.publish(params, function (err, data) {
        if (err) console.log("Error", err);
        else console.log("Success", data);
        return data;
    }).promise().then((result) => console.log('The message was published', result));
  }

  const response = { statusCode: 200, body: JSON.stringify({ message: 'OK' }) };
  callback(null, response);
};
