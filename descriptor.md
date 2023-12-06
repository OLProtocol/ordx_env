通过交易列表查看到三笔交易记录，钱包地址有4个
1 bcrt1prvv9a4ag7hk5836d6nt5sgqu6fxuu9sftsrf7ffyrknm20ms3syq6dnczv
2 bcrt1pfr4845e85pm5jt49jvd9jsyglyvdc7c7e0xhpnvc22x3wqdheyusuj5xw6, bcrt1paz52g5wn80k7rvvlezq8zhmnxzfzamkglnhvh4pjjhsjwv7w67xqt0wxte
3 bcrt1px0z205fc0axnr5zt66p6l2s8gp8hga7u3l0ndtdu3y2k5ldf69hqg9hmcd


```shell
validateaddress bcrt1prvv9a4ag7hk5836d6nt5sgqu6fxuu9sftsrf7ffyrknm20ms3syq6dnczv ## 返回该地址的公钥
```
// listdescriptors true
{
  "wallet_name": "test",
  "descriptors": [
    {
      "desc": "rawtr(cQW4rUw79rop5FPK9j12Kmn3r9sJj7e11hE8Wd3NYNUe1QuxfZH6)#venle4wp",
      "timestamp": 1701833466,
      "active": false
    },
    {
      "desc": "tr([9b26aba5/86'/1'/0']tprv8fxPdxiH1iV3AFkddZuqtB6mt6mYfiiNUXK7MWVN8xgKEmh2FLMP1QkL6SdWQc8ghntCqW6wKzZ2JJQd2krKzQLb8SZemgZPqpWVy2ECNMv/0/*)#d4rdvxcx",
      "timestamp": 1296688602,
      "active": true,
      "internal": false,
      "range": [
        0,
        1000
      ],
      "next": 1,
      "next_index": 1
    },
    {
      "desc": "tr([9b26aba5/86'/1'/0']tprv8fxPdxiH1iV3AFkddZuqtB6mt6mYfiiNUXK7MWVN8xgKEmh2FLMP1QkL6SdWQc8ghntCqW6wKzZ2JJQd2krKzQLb8SZemgZPqpWVy2ECNMv/1/*)#upxv3ng7",
      "timestamp": 1296688602,
      "active": true,
      "internal": true,
      "range": [
        0,
        1002
      ],
      "next": 3,
      "next_index": 3
    }
  ]
}
step 1 
listdescriptors false 
```shell
{
  "wallet_name": "test",
  "descriptors": [
    {
      "desc": "rawtr(48ea7ad327a077492ea5931a594088f918dc7b1ecbcd70cd98528d1701b7c939)#2nszz9hg",
      "timestamp": 1701833466,
      "active": false
    },
    {
      "desc": "tr([9b26aba5/86'/1'/0']tpubDCeRnNkXA6Ai3inRXDaSHaktT8HUq3uH3pute2XfZEUi5FwnsjAyBuNCGYykhBbSuRFbGbJhjmr3J7eW7iAatxeAtrFSXPbs9AjFkuvtFKa/0/*)#8en6afp8",
      "timestamp": 1296688602,
      "active": true,
      "internal": false,
      "range": [
        0,
        1000
      ],
      "next": 1,
      "next_index": 1
    },
    {
      "desc": "tr([9b26aba5/86'/1'/0']tpubDCeRnNkXA6Ai3inRXDaSHaktT8HUq3uH3pute2XfZEUi5FwnsjAyBuNCGYykhBbSuRFbGbJhjmr3J7eW7iAatxeAtrFSXPbs9AjFkuvtFKa/1/*)#kdkmqu3l",
      "timestamp": 1296688602,
      "active": true,
      "internal": true,
      "range": [
        0,
        1002
      ],
      "next": 3,
      "next_index": 3
    }
  ]
}
```
step 2
getdescriptorinfo rawtr(48ea7ad327a077492ea5931a594088f918dc7b1ecbcd70cd98528d1701b7c939)#2nszz9hg
step 3
deriveaddresses "rawtr(48ea7ad327a077492ea5931a594088f918dc7b1ecbcd70cd98528d1701b7c939)#2nszz9hg"
[
"bcrt1pfr4845e85pm5jt49jvd9jsyglyvdc7c7e0xhpnvc22x3wqdheyusuj5xw6"
]

deriveaddresses "tr([9b26aba5/86'/1'/0']tpubDCeRnNkXA6Ai3inRXDaSHaktT8HUq3uH3pute2XfZEUi5FwnsjAyBuNCGYykhBbSuRFbGbJhjmr3J7eW7iAatxeAtrFSXPbs9AjFkuvtFKa/0/*)#8en6afp8" "[0,0]"
[
  "bcrt1prvv9a4ag7hk5836d6nt5sgqu6fxuu9sftsrf7ffyrknm20ms3syq6dnczv"
]

deriveaddresses "tr([9b26aba5/86'/1'/0']tpubDCeRnNkXA6Ai3inRXDaSHaktT8HUq3uH3pute2XfZEUi5FwnsjAyBuNCGYykhBbSuRFbGbJhjmr3J7eW7iAatxeAtrFSXPbs9AjFkuvtFKa/1/*)#kdkmqu3l" "[0,2]"
[
  "bcrt1px0z205fc0axnr5zt66p6l2s8gp8hga7u3l0ndtdu3y2k5ldf69hqg9hmcd",
  "bcrt1paz52g5wn80k7rvvlezq8zhmnxzfzamkglnhvh4pjjhsjwv7w67xqt0wxte"
]










