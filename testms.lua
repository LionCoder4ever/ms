local ms = require('ms')

print(ms:covert('2 days'))
print(ms:covert('1d'))
print(ms:covert('10h'))
print(ms:covert('2.5 hrs'))
print(ms:covert('2h'))
print(ms:covert('1m'))
print(ms:covert('5s'))
print(ms:covert('1y'))
print(ms:covert('100'))
print(ms:covert('-3 days'))
print(ms:covert('-1h'))
print(ms:covert('-200'))


print(ms:covert(60000))
print(ms:covert(2 * 60000))
print(ms:covert(-3 * 60000))
print(ms:covert(ms:covert('10 hours')))


print(ms:covert(60000, {long= true}))
print(ms:covert(2 * 60000, {long= true}))
print(ms:covert(-3 * 60000, {long= true}))
print(ms:covert(ms:covert('10 hours'), {long= true}))


