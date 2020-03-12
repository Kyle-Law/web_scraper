# Web Scraper

> Ruby Capstone Project of Microverse, which students have to complete a real-world-like project within 72 hours according to [this project specifications](https://www.notion.so/microverse/Build-your-own-scraper-f54eaca54d8a4d758a5f0141468127a8)

It's a 3-in-1 Web Scraper, which allows users to parse all courses from udacity.com and jobs from indeed.com and remote.io into CSV file. 

![image](https://user-images.githubusercontent.com/55923773/76555459-a1e0de80-64d2-11ea-85f1-3e8209ad2b10.png)
![image](https://user-images.githubusercontent.com/55923773/76562091-934cf400-64df-11ea-8eb5-a0bf44be1394.png)
<small><small><center>Job Scraped from Remote.io</center></small></small>
![image](https://user-images.githubusercontent.com/55923773/76562763-06a33580-64e1-11ea-8ab4-9c498d4fd947.png)
<small><small><center>Job Scraped from indeed.com</center></small></small>
![image](https://user-images.githubusercontent.com/55923773/76562843-2dfa0280-64e1-11ea-8310-9637c57daa23.png)
<small><small><center>Courses Scraped from udacity.com</center></small></small>

## Built With

- Ruby
- Nokogiri gem
- HTTParty gem

## Project Structure

```
├── README.md
├── bin
│   └── main.rb
└── lib
    └── scraper.rb
    └── udacity_scraper.rb
    └── indeed_scraper.rb
    └── remoteio_scraper.rb
└── rspec
    └── scraper_spec.rb
    └── spec_helper.rb
```

## Video Presentation
Feel free to check out this [link](https://youtu.be/fc7P5Y0NTcM) for a 3min video walkthrough :)

## Run tests
1) Git clone this repo and cd the to the `web_scraper` directory.
2) Install rspec with `gem install rspec`.
3) Run `rspec` in Command Line.
4) You would see failures because all 3 scraped files haven't been created yet.
5) To solve it, run `ruby bin/main.rb` and input 'udacity', 'indeed', and 'remote.io' for every execution.
6) Run `rspec` in CLI again. The test cases would success upon each file created :)


## Deployment
1) Git clone this repo and cd the to the `web_scraper` directory.
2) Run `bin/main.rb`.
3) Input either 'udacity', 'indeed', or 'remote.io' and follows the respective commands.
4) Tada! 'udacity_courses.csv', 'indeed_jobs.csv', or 'remote_io.csv' would be created at the root directory respectively :)

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
- Udacity.com
- Indeed.com
- Remote.io

## 📝 License

This project is [MIT](LICENSE) licensed.
