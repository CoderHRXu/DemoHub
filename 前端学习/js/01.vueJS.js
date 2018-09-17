/**
 * Created by haoran on 2018/9/14.
 */

var app = new Vue({

    el: "#app",
    data: {
        seen: true,
        message: 'Hello Vue!',
        site: "vue learn",
        url: "http://www.akpop.top",
        alexa: "10000"

    },
    methods: {

        details: function () {
            return this.state + ' - 开始正式学习了'
        }
    }
})

app.message = 'message is changed';

// // app.seen = false;
//
// var vm = new Vue({
//
//     el:"#vue_det",
//     data:{
//         seen:true,
//         message : 'Hello Vue!',
//
//         site : "vue learn",
//         url: "http://www.akpop.top",
//         alexa: "10000"
//
//     },
//
//     methods: {
//             return this.state + ' - 开始正式学习了'
//         }
//     }
// )