require('nodefly').profile(
    '7ac5417c-874e-49c6-81cf-ea13c72a1300',
    [APPLICATION_NAME,'Heroku'],
    options // optional
);

require('coffee-script')

var cloudBox = require('./app/cloud-box.coffee');

cloudBox.start();