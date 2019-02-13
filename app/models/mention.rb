class Mention
    attr_reader :mentionable
    include Rails.application.routes.url_helpers
  
    def self.all(letters)
      return Mention.none unless letters.present?
      users = User.limit(5).where('username like ?', "#{letters}%").compact
      users.map do |user|
        { name: user.username, picture: user.picture }
      end
    end
  
    def self.create_from_text(post)
      potential_matches = post.content.scan(/@\w+/i)
      potential_matches.uniq.map do |match|
        mention = Mention.create_from_match(match)
        next unless mention
        post.update_attributes!(content: mention.markdown_string(post.content))
        # You could fire an email to the user here with ActionMailer
        mention
      end.compact
    end
  
    def self.create_from_match(match)
      user = User.find_by(username: match.delete('@'))
      UserMention.new(user) if user.present?
    end
  
    def initialize(mentionable)
      @mentionable = mentionable
    end
  
    class UserMention < Mention
      def markdown_string(text)
        host = Rails.env.development? ? 'localhost:3000' : '' # add your app's host here!
        text.gsub(/@#{mentionable.username}/i,
                  "[**@#{mentionable.username}**](#{user_url(mentionable, host: host)})")
      end
    end
  end
  