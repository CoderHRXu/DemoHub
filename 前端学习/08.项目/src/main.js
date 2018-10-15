/**
 * Created by haoran on 2018/10/15.
 */

// 1.0 导入vue核心包
import Vue from 'vue'


// 2.0 导入App.vue的vue对象
import App from 'App.vue'

// 3.0 利用vue对象进行解析渲染
new Vue({

    el:'#app',
    /* es5 写法
    render:function (create) {
        create(App)
    }
    */
    render:c => c(App) // es6写法  =>: goes to
});