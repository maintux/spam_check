# Simple HTTP interface for SpamAssassin check

This can be used to pre or post process email content when it is used in your application. For instance, if you process incoming emails from your users you can first run it through the API to filter out junk and avoid clutter in your database and application.

## Usage
* Log into server which provides SpamAssassin
* Clone repo: `git clone https://github.com/maintux/spam_check.git`
* Edit HTTP_AUTHORIZATION token
* Install sinatra gem: `gem install sinatra`
* Start sinatra application running `ruby spam_check.rb`
* Make your request:
```bash
curl -X POST http://127.0.0.1:4567/filter
  -H "Accept: application/json"
  -H 'Authorization: Token token="your_sha1_token"'
  --data "email=row_email_string"
```
* Get your json response:
```js
{
  'success': false,  // Failure on the spamassassin processing side will be present in the report and will not affect this value.
  'message': string // If success is False, this will contain the error message. Note that this is an application error, and not a web server error. Web server errors are the default standard HTTP messages.
}
```
```js
{
  'success': true,
  'score': value  // This will contain the SpamAssassin score.
}
```