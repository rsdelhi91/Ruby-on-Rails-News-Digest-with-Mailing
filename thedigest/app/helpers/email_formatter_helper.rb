require 'mandrill'
## handles the email function of the digest, will perform a email
## send to every subscriber, with up to 10 feeds
module EmailFormatterHelper
  attr_accessor :subscriber_list

  # update the subscriber list
  def update_subscriber_list
    @mandrill = Mandrill::API.new 'nDSi_tYPhOy6QpG8Kn_lqg'
    @subscriber_list = User.where(isSubscribed: true)
  end

  def send_email_to_all
    @subscriber_list.each do |subscriber|
      # match the interest list
      articles = match_news(subscriber)

      # generate message
      email = generate_message(subscriber)

      # send the email
      status = send_email_to_user(subscriber, email, articles)

      if !status.nil?
        logger.debug "email sending to #{subscriber}" + status.to_s
      else
        logger.debug 'email sending failed'
      end
    end
  end

  # for each given user, get his/her 10 news feed of interst
  def match_news(subscriber)
    # retrieve the interest feeds for the user
    match_list = Article.tagged_with(subscriber.interest_list, any: true).to_a
    puts match_list.size

    if match_list.size == 0
      match_list = nil
    else
      # sort the list by pub date
      match_list.sort! { |a, b| b.pubDate <=> a.pubDate }
      non_dup_match_list = []
      puts non_dup_match_list.size

      match_list.each do |art|
        if UserArticle.where(user_id: subscriber.id, article_id: art.id).empty?
          UserArticle.create(user_id: subscriber.id, article_id: art.id)
          non_dup_match_list << art
        else
          puts art.id
        end
      end
      puts non_dup_match_list.size
      article = non_dup_match_list[0...9]

      # return the array
      article = nil if article.size == 0
      article
    end
  end

  # generate the email content and return the message for use of mandrill
  def generate_message(user)
    message = {
      subject: 'Test',
      from_name: 'The Digest!',
      text: 'This is a testing email',
      to: [
        {
          email: user.email,
          name: user.firstname
        }
      ],

      html: '',
      from_email: 'admin@thedigest.com'
    }
  end

  def send_email_to_user(_user, message, articles)
    i = 1
    template_name = 'RSS_feed'
    template_content = []
    if articles.nil?
      # template_name = "RSS_feed"
      template_content.push("name": 'article1', "content":
        "<h2>Oops, we don't have new articles for you. Go explore new things!\
        </h2>")
    else
      articles.each do |article|
        template_content.push("name": "article#{i}", "content":
          "<h2>#{article.title}</h2>Source: #{article.source}<br>\
          <a href=\"#{article.link}\">read more..</a><br> #{article.pubDate}")
        i += 1
      end
    end
    async = true
    status = @mandrill.messages.send_template(template_name,
                                              template_content, message, async)
  end
end
