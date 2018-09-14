/**
 * Created by haoran on 2018/9/14.
 */

var app = new Vue({

    el:"#app",
    data:{
        seen:true,
        message : 'Hello Vue!'
    }
})

app.message = 'message is changed';
// app.seen = false;