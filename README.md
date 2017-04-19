### mcheyne-api

A Sinatra app that returns the current day's readings from [Robert Murray M'Cheyne's Bible reading plan](http://hippocampusextensions.com/mcheyneplan/).

#### Setup
```
git clone git@github.com:speric/mcheyne-api.git
cd mcheyne-api
script/server
```

The app will now be available at [http://localhost:9292](http://localhost:9292)

#### Response
The response for a `GET` request to `/` takes the following shape:
```
{
  "mmdd": "0418",
  "family": [
    "Leviticus 22",
    "Psalms 28-29"
  ],
  "secret": [
    "Ecclesiastes 5",
    "2 Timothy 1"
  ],
}
```

#### Contributing
PRs welcome.
