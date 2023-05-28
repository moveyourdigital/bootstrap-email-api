# Bootstrap Email Transpiler REST API

A Ruby dockerized service that receives a [Bootstrap Email](https://bootstrapemail.com/) payload and returns an HTML 3.0 responsive tabled layout that works for the following email clients:
- Apple Mail macOS
- Apple Mail iOS
- Outlook 2000 - 2003 (IE Render)
- Outlook 2007 - 2013 (MS Word Render)
- Outlook 2016
- Outlook.com (the new Hotmail)
- Windows 10 Mail
- Yahoo!
- AOL Mail
- Android Mail
- Gmail
- Gmail App
- Inbox by Gmail
- Modern Email Clients
- Any many more...

## Usage
1. Pull docker image
```
docker pull moveyourdigital/bootstrap-email-api
```
2. Run a container
```
docker run -p 9292:9292 moveyourdigital/bootstrap-email-api
```
3. Test using curl
```
curl -XPOST -H "Content-Type: application/json" http://127.0.0.1:9292/ -d '{"html": "<a href=\"#\" class=\"btn btn-primary\">Button</a>"}'
```
An HTML 3.0 should be returned.

# Stack:
- ruby (3.2)
- rack (2.2)
- puma (2.2)
- hanami-api (0.3)
- bootstrap-email (1.4.0)
