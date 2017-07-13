# Chat Notifications

Heaven looks for information in the environments and tries to give feedback to chat rooms to everyone knows that code has been deployed. Right now it supports three networks.

All notifications run inside of [resque][3] jobs and need to define a deliver method.

### Example Provider

```ruby
module Heaven
  module Notifier
    class MyChat < Default
      def deliver(message)
      end
    end
  end
end
```

## SlackHQ

### Configuration

| Environmental Variables |                                                 |
|-------------------------|-------------------------------------------------|
| SLACK_WEBHOOK_URL       | A Slack Webhook URL from [incoming-webhook][21] section of Slack|
| SLACK_BOT_NAME          | The name to post to Slack as. Defaults to `hubot`|
| SLACK_BOT_ICON          | The icon to use for the notification. Defaults to `https://octodex.github.com/images/labtocat.png`|

## Campfire

### Configuration

| Environmental Variables |                                                 |
|-------------------------|-------------------------------------------------|
| CAMPFIRE_TOKEN          | A campfire API token from the 'my info' section of [campfire][7].                               |
| CAMPFIRE_SUBDOMAIN      | This subdomain for the campfire. For example https://atmos.campfirenow.com would be 'atmos'  |

## HipChat

### Configuration

| Environmental Variables |                                                 |
|-------------------------|-------------------------------------------------|
| HIPCHAT_TOKEN           | The notification token to send messages to hipchat. |
| HIPCHAT_ROOM            | The room to post deployment messages to.        |

## Commit Change Notifications

Successful deployments to any environment are always compared with the last
successful deployment to the production environment.

| Environmental Variables |                                                                                  |
| ----------------------- | -------------------------------------------------------------------------------- |
| HEAVEN_NOTIFIER_DISPLAY_COMMITS       | Add to send a list of commit changes after a succesful deployment. |
| HEAVEN_NOTIFIER_DISPLAY_COMMITS_LIMIT | Limit the number of commits listed in the notification.            |

[1]: http://developer.github.com/v3/repos/deployments/
[2]: https://github.com/blog/1778-webhooks-level-up
[3]: https://github.com/resque/resque
[4]: https://gist.github.com/
[5]: https://developer.github.com/v3/repos/deployments/#create-a-deployment
[6]: https://developer.github.com/v3/repos/deployments/#create-a-deployment-status
[7]: https://campfirenow.com/
[8]: https://www.hipchat.com/
[9]: https://slack.com/
[10]: http://www.fabfile.org/
[11]: http://www.getchef.com/
[12]: http://puppetlabs.com/
[13]: https://devcenter.heroku.com/articles/build-and-release-using-the-api
[14]: https://developer.github.com/v3/repos/contents/#get-archive-link
[15]: http://capistranorb.com/
[16]: https://github.com/settings/applications
[17]: https://devcenter.heroku.com/articles/oauth#direct-authorization
[18]: https://www.phusionpassenger.com/
[19]: https://devcenter.heroku.com/articles/releases
[20]: https://github.com/atmos/hubot-deploy
[21]: https://my.slack.com/services/new/incoming-webhook
[23]: https://gist.github.com/Mumakil/1d184a3f06bcd087c5e2
