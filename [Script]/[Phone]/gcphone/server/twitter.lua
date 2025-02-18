--
--  LEAKED BY S3NTEX -- 
--  https://discord.gg/aUDWCvM -- 
--  fivemleak.com -- 
--  fkn crew -- 
function TwitterPostTweet(a, b, c, d, e)
    getUser(d, function(f)
        MySQL.Async.fetchAll("INSERT INTO twitter_tweets (`authorId`, `message`, `image`, `realUser`) VALUES(@authorId, @message, @image, @realUser);", {["@authorId"] = f.id, ["@message"] = a, ["@image"] = b, ["@realUser"] = d}, function()
            tweet = {}
            tweet["authorId"] = f.id;
            tweet["message"] = a;
            tweet["image"] = b
            tweet["realUser"] = d;
            tweet["time"] = os.date()
            tweet["realtime"] = os.date("%H"..":%M")
            tweet["author"] = f.author;
            tweet["authorIcon"] = f.authorIcon;
            TriggerClientEvent("gcPhone:twitter_newTweets", -1, tweet) 
            if string.match(b, '?') or string.match(b, 'png') or string.match(b, 'jpeg') or string.match(b, 'jpg') or string.match(b, 'pjg') or string.match(b, 'gif') then
                TriggerClientEvent('chat:addMessage', -1, { -- ของถ่ายรูป
                  template = [[<div style=" display: flex;
                    justify-content: space-between;
                    width: fit-content;
                    max-width: 100%;
                    height: auto;
                    background: linear-gradient(to right, rgba(0, 0, 0, 0.8), rgba(66, 66, 66, 0.8));
                    border-radius: 12px; 
                    animation-name: slideout; 
                    animation-duration: 1s; ">
                      <div style="    display: flex;
                      flex-direction: column;
                      margin-left: 8vh;
                      width: 80%;
                      height: 80%;">
                      <span style="    color: #FFD700;
                      margin-left: 0.0vw;
                      margin-top: 0.0vh;
                      margin-right: 0.7vw;
                      font-weight: 1000;">@{1}</span>
                      <span style="    color: rgba(255, 255, 255,0.7);
                      overflow-wrap: break-word;
                      text-shadow: 0px 1px 2px rgba(0, 150, 255,0.7);
                      font-size: 0.9em;
                      margin-left: 0.1vw;
                      font-weight: 500;
                      margin-top: 0.2vh; margin-bottom: 0.2vh;">{2}</span>
                      <div style=" width: 15vw; height: 16vh; overflow: hidden; position: relative; margin-bottom:0.8vh;">
                            <img src="{4}" width="100%; border-radius: 18px" style="border-radius: 12px; margin-top: 6px;"></div>
                      </div>
                      <div style="    position: absolute;
                      width: 2.5vw;
                      height: 4.5vh;
                      margin: 0.8vh;
                      margin-top: 2.0vh;
                      margin-left: 0.7vw;
                      background-color: rgba(20, 20, 20, 0.8);
                      box-shadow: 0px 0px 15px #b99e00;
                      border: 2px solid #FFD700;
                      border-radius: 15px;
                      overflow: hidden;"> 
                      <img src="{0}" style="    
                      margin-left: -2.7vw;
                      margin-top: -3.0vh;
                      width: 385%;
                      height: 200%;"></img></div>
                      <span style=" color: rgba(255, 255, 255,0.7);
                      font-size: 0.7em;
                      text-align: right;
                      margin-top: 1.1vw;
                      margin-right: 0.6vw;">{3}</span>
                     </div>]],
                args = { tweet["authorIcon"], tweet['author'] , a , tweet["realtime"], b}})
            else
              TriggerClientEvent('chat:addMessage', -1, { -- ของข้อความ
                    template = [[<div  style=" display: flex;
                    justify-content: space-between;
                    width: fit-content;
                    max-width: 100%;
                    height: auto;
                    background: linear-gradient(to right, rgba(0, 0, 0, 0.8), rgba(66, 66, 66, 0.8));
                    border-radius: 12px; 
                    animation-name: slideout; 
                    animation-duration: 1s;
                    ">
                      <div style="    display: flex;
                      flex-direction: column;
                      margin-left: 8vh;
                      width: 80%;
                      height: 80%;">
                      <span style="    color: #FFD700;
                      margin-left: 0.0vw;
                      margin-top: 1.5vh;
                      margin-right: 0.7vw;
                      font-weight: 1000;">@{1}</span>
                      <span style="    color: rgba(255, 255, 255,0.7);
                      overflow-wrap: break-word;
                      text-shadow: 0px 1px 2px rgba(0, 150, 255,0.7);
                      font-size: 0.9em;
                      margin-left: 0.1vw;
                      font-weight: 500;
                      margin-top: 0.2vh; margin-bottom: 1.4vh;">{2}</span>
                      </div>
                      <div style="    position: absolute;
                      width: 2.5vw;
                      height: 4.5vh;
                      margin: 0.8vh;
                      margin-top: 1.2vh;
                      margin-left: 0.7vw;
                      background-color: rgba(20, 20, 20, 0.8);
                      box-shadow: 0px 0px 15px #b99e00;
                      border: 2px solid #FFD700;
                      border-radius: 15px;
                      overflow: hidden;"> 
                      <img src="{0}" style="    
                      margin-left: -2.7vw;
                      margin-top: -3.0vh;
                      width: 385%;
                      height: 200%;"></img></div>
                      <span style=" color: rgba(255, 255, 255,0.8);
                      font-size: 0.7em;
                      text-align: right;
                      margin-top: 1.1vw;
                      margin-right: 0.6vw;">{3}</span>
                     </div>]],
                args = { tweet["authorIcon"], tweet['author'] , a , tweet["realtime"]}})
            end
        TriggerEvent("gcPhone:twitter_newTweets", tweet)
      end)
    end)
  end

function TwitterGetTweets(a, b) 
  if a == nil then 
    MySQL.Async.fetchAll([===[SELECT twitter_tweets.*, twitter_accounts.username as author, twitter_accounts.avatar_url as authorIcon FROM twitter_tweets LEFT JOIN twitter_accounts ON twitter_tweets.authorId = twitter_accounts.id ORDER BY time DESC LIMIT 30]===], {}, b) else 
      MySQL.Async.fetchAll([===[SELECT twitter_tweets.*, twitter_accounts.username as author, twitter_accounts.avatar_url as authorIcon, twitter_likes.id AS isLikes FROM twitter_tweets LEFT JOIN twitter_accounts ON twitter_tweets.authorId = twitter_accounts.id LEFT JOIN twitter_likes ON twitter_tweets.id = twitter_likes.tweetId AND twitter_likes.authorId = @accountId ORDER BY time DESC LIMIT 30]===], {["@accountId"] = a}, b) 
    end 
  end


function TwitterGetFavotireTweets(accountId, cb)
    MySQL.Async.fetchAll([===[
      SELECT twitter_tweets.*,
        twitter_accounts.username as author,
        twitter_accounts.avatar_url as authorIcon
      FROM twitter_tweets
        LEFT JOIN twitter_accounts
          ON twitter_accounts.identifier = @accountId
      WHERE realUser = @accountId ORDER BY TIME DESC LIMIT 30
    ]===]
        
        
        
        
        
        
        
        , {['@accountId'] = accountId}, cb)
end

function getUser(identifier, cb)
    MySQL.Async.fetchAll("SELECT id, username as author, avatar_url as authorIcon FROM twitter_accounts WHERE identifier = @identifier", {
        ['@identifier'] = identifier
    }, function(data)
        cb(data[1])
    end)
end


function TwitterToogleLike(identifier, tweetId, sourcePlayer)
    getUser(identifier, function(user)
        MySQL.Async.fetchAll('SELECT * FROM twitter_tweets WHERE id = @id', {
            ['@id'] = tweetId
        }, function(tweets)
            if (tweets[1] == nil) then return end
            local tweet = tweets[1]
            MySQL.Async.fetchAll('SELECT * FROM twitter_likes WHERE authorId = @authorId AND tweetId = @tweetId', {
                ['authorId'] = user.id,
                ['tweetId'] = tweetId
            }, function(row)
                if (row[1] == nil) then
                    MySQL.Async.insert('INSERT INTO twitter_likes (`authorId`, `tweetId`) VALUES(@authorId, @tweetId)', {
                        ['authorId'] = user.id,
                        ['tweetId'] = tweetId
                    }, function()
                        MySQL.Async.execute('UPDATE `twitter_tweets` SET `likes`= likes + 1 WHERE id = @id', {
                            ['@id'] = tweet.id
                        }, function()
                            TriggerClientEvent('gcPhone:twitter_updateTweetLikes', -1, tweet.id, tweet.likes + 1)
                            TriggerClientEvent('gcPhone:twitter_setTweetLikes', sourcePlayer, tweet.id, true)
                            TriggerEvent('gcPhone:twitter_updateTweetLikes', tweet.id, tweet.likes + 1)
                        end)
                    end)
                else
                    MySQL.Async.execute('DELETE FROM twitter_likes WHERE id = @id', {
                        ['@id'] = row[1].id,
                    }, function()
                        MySQL.Async.execute('UPDATE `twitter_tweets` SET `likes`= likes - 1 WHERE id = @id', {
                            ['@id'] = tweet.id
                        }, function()
                            TriggerClientEvent('gcPhone:twitter_updateTweetLikes', -1, tweet.id, tweet.likes - 1)
                            TriggerClientEvent('gcPhone:twitter_setTweetLikes', sourcePlayer, tweet.id, false)
                            TriggerEvent('gcPhone:twitter_updateTweetLikes', tweet.id, tweet.likes - 1)
                        end)
                    end)
                end
            end)
        end)
    end)
end

function TwitterToogleDelete(identifier, tweetId, sourcePlayer)
    MySQL.Async.execute('DELETE FROM twitter_tweets WHERE id = @id', {
        ['@id'] = tweetId,
    }, function()
        TwitterGetFavotireTweets(identifier, function(tweets)
            TriggerClientEvent('gcPhone:twitter_getFavoriteTweets', sourcePlayer, tweets)
        end)
    end)
end

function TwitterShowError(sourcePlayer, title, message)
    TriggerClientEvent('gcPhone:twitter_showError', sourcePlayer, message)
end

function TwitterShowSuccess(sourcePlayer, title, message)
    TriggerClientEvent('gcPhone:twitter_showSuccess', sourcePlayer, title, message)
end

RegisterServerEvent('gcPhone:twitter_login')
AddEventHandler('gcPhone:twitter_login', function(source, identifier)
    local sourcePlayer = tonumber(source)
    getUser(identifier, function(user)
        if user ~= nil then
            TriggerClientEvent('gcPhone:twitter_setAccount', sourcePlayer, user.author, user.authorIcon)
        end
    end)
end)

RegisterServerEvent('gcPhone:twitter_changeUsername')
AddEventHandler('gcPhone:twitter_changeUsername', function(newUsername)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    getUser(identifier, function(user)
        MySQL.Async.execute("UPDATE `twitter_accounts` SET `username`= @newUsername WHERE identifier = @identifier", {
            ['@identifier'] = identifier,
            ['@newUsername'] = newUsername
        }, function(result)
            if (result == 1) then
                TriggerClientEvent('gcPhone:twitter_setAccount', sourcePlayer, newUsername, user.authorIcon)
            end
        end)
    end)
end)

RegisterServerEvent('gcPhone:twitter_setAvatarUrl')
AddEventHandler('gcPhone:twitter_setAvatarUrl', function(avatarUrl)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    getUser(identifier, function(user)
        MySQL.Async.execute("UPDATE `twitter_accounts` SET `avatar_url`= @avatarUrl WHERE identifier = @identifier", {
            ['@identifier'] = identifier,
            ['@avatarUrl'] = avatarUrl
        }, function(result)
            if (result == 1) then
                TriggerClientEvent('gcPhone:twitter_setAccount', sourcePlayer, user.author, avatarUrl)
            end
        end)
    end)
end)


RegisterServerEvent('gcPhone:twitter_getTweets')
AddEventHandler('gcPhone:twitter_getTweets', function()
    local sourcePlayer = tonumber(source)
    if username ~= nil and username ~= "" and password ~= nil and password ~= "" then
        getUser(username, password, function(user)
            local accountId = user and user.id
            TwitterGetTweets(accountId, function(tweets)
                TriggerClientEvent('gcPhone:twitter_getTweets', sourcePlayer, tweets)
            end)
        end)
    else
        TwitterGetTweets(nil, function(tweets)
            TriggerClientEvent('gcPhone:twitter_getTweets', sourcePlayer, tweets)
        end)
    end
end)

RegisterServerEvent('gcPhone:twitter_getFavoriteTweets')
AddEventHandler('gcPhone:twitter_getFavoriteTweets', function()
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    TwitterGetFavotireTweets(srcIdentifier, function(tweets)
        TriggerClientEvent('gcPhone:twitter_getFavoriteTweets', sourcePlayer, tweets)
    end)
end)

RegisterServerEvent('gcPhone:twitter_postTweets')
AddEventHandler('gcPhone:twitter_postTweets', function(message, image)
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    TwitterPostTweet(message, image, sourcePlayer, srcIdentifier)
end)

RegisterServerEvent('gcPhone:twitter_toogleLikeTweet')
AddEventHandler('gcPhone:twitter_toogleLikeTweet', function(tweetId)
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    TwitterToogleLike(srcIdentifier, tweetId, sourcePlayer)
end)

RegisterServerEvent('gcPhone:twitter_toggleDeleteTweet')
AddEventHandler('gcPhone:twitter_toggleDeleteTweet', function(tweetId)
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    TwitterToogleDelete(srcIdentifier, tweetId, sourcePlayer)
end)


--[[
Discord WebHook
set discord_webhook 'https//....' in config.cfg
--]]
function sendDiscordTwitter(tweet)
    local discord_webhook = GetConvar('twitter_discord_webhook', '')
    if discord_webhook == '' then
        return
    end
    local headers = {
        ['Content-Type'] = 'application/json'
    }
    local data = {
        ["username"] = tweet.author,
        ["embeds"] = {{
            ["thumbnail"] = {
                ["url"] = tweet.authorIcon
            },
            ["color"] = 1942002
        }}
    }
    if tweet.image ~= "" then
        data['embeds'][1]['image'] = {['url'] = tweet.image}
    end
    tweet.message = tweet.message:gsub("{{{", ":")
    tweet.message = tweet.message:gsub("}}}", ":")
    data['embeds'][1]['description'] = tweet.message
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end

AddEventHandler('gcPhone:twitter_newTweets', function (tweet)
  -- print(json.encode(tweet))
  local discord_webhook = GetConvar('discord_webhook', '')
  if discord_webhook == '' then
    return
  end
  local headers = {
    ['Content-Type'] = 'application/json'
  }
  local data = {
    ["username"] = tweet.author,
    ["embeds"] = {{
      ["thumbnail"] = {
        ["url"] = tweet.authorIcon
      },
      ["color"] = 1942002,
      ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ", tweet.time / 1000 )
    }}
  }
	if tweet.image ~= "" then
		data['embeds'][1]['image'] = {['url'] = tweet.image}
	end
	tweet.message = tweet.message:gsub("{{{", ":")
	tweet.message = tweet.message:gsub("}}}", ":")
	data['embeds'][1]['description'] = tweet.message
  local isHttp = string.sub(tweet.message, 0, 7) == 'http://' or string.sub(tweet.message, 0, 8) == 'https://'
  local ext = string.sub(tweet.message, -4)
  local isImg = ext == '.png' or ext == '.pjg' or ext == '.gif' or string.sub(tweet.message, -5) == '.jpeg'
  if (isHttp and isImg) and true then
    data['embeds'][1]['image'] = { ['url'] = tweet.message }
  else
    data['embeds'][1]['description'] = tweet.message
  end
  PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end)
