Foosball Tracker
----------------

This project was started to have so that the [Magoosh](http://magoosh.com)/[EasyESI](http://easyesi.com) office could have an app to track their Foosball games.

It uses the [TrueSkill algorithm](http://github.com/saulabs/trueskill) to provide accurate rankings for players and chart them over time.

Deploying to Heroku
-------------------
1. Follow steps 1-3 of the Heroku quickstart guide: (http://devcenter.heroku.com/articles/quickstart)
2. Run the following commands from your terminal:

```
git clone git://github.com/zmillman/foosball_tracker.git
cd foosball_tracker
heroku create --stack cedar
git push heroku master
heroku run rake db:migrate
```

[![Code Climate](https://codeclimate.com/github/zmillman/foosball_tracker.png)](https://codeclimate.com/github/zmillman/foosball_tracker)
