users = [
  {
    id: 1
    username: '1'
    password: '1'
    fullName: '闻花'
    email: 'bob@example.com' },
  {
    id: 2
    username: '2'
    password: '2'
    fullName: '一珺'
    email: 'joe@example.com' }
]

exports.findById = (id, fn) ->
  idx = id - 1
  if users[idx] then fn null, users[idx]
  else fn new Error "User #{id} does not exist"

exports.findByUsername = (username, fn) ->
  for user in users
    if user.username is username then return fn null, user
  fn null, null