1. Create a new application on Heroku <br>
$ heroku create <br>

2. Commit <br>
$ git add -A <br>
$ git commit -m "init" <br>

3. Deploy to Heroku <br>
$ git push heroku master <br>

4. Database migration <br>
$ heroku run rails db:migrate <br>

User Model
|Column name  |Data type |
|-------------|----------|
|name         |string    |
|email        |string    |
|password     |string    |
|password<br>
_confirm      |string    |


Task Model
|Column name　|Data type  |
|-------------|-----------|
|name         |string     |
|description  |text       |



Label Model
|Column name  |Data type |
|-------------|----------|
