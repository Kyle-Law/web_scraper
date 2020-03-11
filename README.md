# Web Scraper

> Ruby Capstone Project of Microverse, which students have to complete a real-world-like project within 72 hours.

It's a 3-in-1 Web Scraper, which allows users to parse all courses from udacity.com and jobs from indeed.com and remote.io. 

![image](https://user-images.githubusercontent.com/55923773/76449588-4f86bb80-6407-11ea-8016-6c00f0d53c24.png)

![image](https://user-images.githubusercontent.com/55923773/76449672-75ac5b80-6407-11ea-82b4-1f20a4d8d2dd.png)

## Built With

- Ruby
- Nokogiri gem
- HTTParty gem
- byebug gem

## Video Presentation
Feel free to check out this [link](https://youtu.be/86i3kE8AFqk) for a video walkthrough :)

### Run tests
1) Git clone this repo and cd the to the `web_scraper` directory.
2) Install rspec with `gem install rspec`
3) Run `rspec spec/scraper_rspec.rb`
4) You would see failures because all 3 scraped files haven't been created yet.
5) To solve it, run `ruby bin/main.rb` and input 'udacity', 'indeed', and 'remote.io' for every execution.
6) Run `rspec spec/scraper_rspec.rb` again. The test cases would success upon each file created :)


### Deployment
1) Git clone this repo and cd the to the `web_scraper` directory.
2) Run `ruby bin/main.rb`
3) Input either 'udacity', 'indeed', or 'remote.io'
4) Tada! 'udacity_courses.txt', 'indeed_jobs.txt', or 'remote_io.txt' would be created at the root directory respectively.
5) The default URLs for indeed.com and remote.io are catered for Ruby-on-Rails remote job opportunities. Feel free to change the default URL in `lib/scraper.rb` to suit your specifications. :)

## Authors

👤 **Kyle Law**

- Github: [@Kyle-Law](https://github.com/Kyle-Law)
- Twitter: [@Kyle-Law](https://twitter.com/ZhunKhing)
- Linkedin: [Kyle law](https://www.linkedin.com/in/kyle-lawzhunkhing/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/Kyle-Law/web_scraper/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Microverse
- Nokogiri gem
- HTTParty Parser
- byebug gem

## 📝 License

This project is [MIT](lic.url) licensed.
