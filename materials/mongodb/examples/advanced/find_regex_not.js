var non_effs = db.users.find({
  lastname: { $not: /^f/i}
}, {firstname: 1, lastname: 1}).limit(2);

non_effs.forEach(printjson);