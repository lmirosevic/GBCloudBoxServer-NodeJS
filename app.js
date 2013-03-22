require('nodefly').profile(
    process.env.NODEFLY_APPLICATION_KEY,
    [process.env.APPLICATION_NAME,'Heroku']
);

require('coffee-script')

var cloudBox = require('./app/cloud-box.coffee');

cloudBox.start();