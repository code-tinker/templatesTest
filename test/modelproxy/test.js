var modelproxy = require("modelproxy");

modelproxy.init('./interface.json');

var searchModel = new modelproxy({
    searchItems : 'Search.getItems'
});

searchModel.searchItems({q:'123'})
    .done(function(data){
        console.log(data);
    })
    .error(function(err){
        console.log(err);
    });
