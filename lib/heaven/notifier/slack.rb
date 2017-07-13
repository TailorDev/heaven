require "heaven/comparison/linked"

module Heaven
  module Notifier
    # A notifier for Slack
    class Slack < Notifier::Default
      def deliver(message)
        output_message   = ""
        filtered_message = slack_formatted(message)

        Rails.logger.info "slack: #{filtered_message}"
        Rails.logger.info "message: #{message}"

        if pending? || deployment_desc =~ /Auto-Deployed/
          output_message = "New deployment triggered :rocket: (##{deployment_number})"
        end

        slack_account.ping "",
          :channel     => "##{chat_room}",
          :username    => slack_bot_name,
          :icon_url    => slack_bot_icon,
          :attachments => [{
            :text      => filtered_message,
            :color     => green? ? "good" : "danger",
            :pretext   => output_message,
            :mrkdwn_in => ["text", "pretext"]
          }]
      end

      def default_message
        message = output_link("##{deployment_number}")
        message << " : #{user_link}"

        auto = " "
        if deployment_desc =~ /Auto-Deployed/
          auto = pending? ? " *automatically* " : " *automatic* "
        end

        case state
        when "success"
          if locked?
            message = "#{user_link} locked #{repository_link} in #{environment}! "
          elsif unlocked?
            message = "#{user_link} unlocked #{repository_link} in #{environment}! "
          else
            message << "'s#{auto}#{environment} deployment of #{repository_link} is done! "

            if not environment_url.strip.empty?
              message << "Check it out at: #{environment_url}"
            end

            message
          end
        when "failure"
          message << "'s#{auto}#{environment} deployment of #{repository_link} failed. "
        when "error"
          message << "'s#{auto}#{environment} deployment of #{repository_link} has errors"
          message << ": #{description}" unless description =~ /Deploying from Heaven/
        when "pending"
          message << " is deploying#{auto}#{repository_link("/tree/#{ref}")} to #{environment}."
        else
          puts "Unhandled deployment state, #{state}"
        end
      end

      def slack_formatted(message)
        ::Slack::Notifier::Util::LinkFormatter.format(message)
      end

      def changes
        Heaven::Comparison::Linked.new(comparison, name_with_owner).changes(commit_change_limit)
      end

      def compare_link
        "([compare](#{comparison["html_url"]}))" if last_known_revision
      end

      def slack_webhook_url
        ENV["SLACK_WEBHOOK_URL"]
      end

      def slack_bot_name
        ENV["SLACK_BOT_NAME"] || "hubot"
      end

      def slack_bot_icon
        ENV["SLACK_BOT_ICON"] || "https://octodex.github.com/images/labtocat.png"
      end

      def slack_account
        @slack_account ||= ::Slack::Notifier.new(slack_webhook_url)
      end
    end
  end
end
