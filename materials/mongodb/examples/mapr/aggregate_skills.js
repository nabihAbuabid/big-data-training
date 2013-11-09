var skills = db.users.aggregate(
  [
    { $unwind : "$skills" },
    { $group : { _id : "$skills" , number : { $sum : 1 } } },
    { $sort : { number : -1 } },
    { $limit : 50 }
  ]
);

printjson(skills);