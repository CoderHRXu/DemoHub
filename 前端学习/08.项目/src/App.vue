/**
* Created by haoran on 2018/10/15.
*/

<!-- 以后项目的根组件  -->

<template>
    <!-- 1.0 template主要是放html元素的(html的页面结构) -->

    <span v-text="msg" class="red"></span>

</template>


<script>


    function add(x , y) {
        return console.log( x + y ) ;
    }


    // import calc from 'calc.js';
    import {add} from 'calc.js';

    // 负责导出 .vue这个组件对象(它本质是一个vue对象，所以vue中该定义的元素都可以使用)
    // module.exports = {  // es5 导出对象的方法
    export default {
            data(){        // 等价于 es5 => data:function () {
                return {
                    msg : 'hello vue.js!'
                };
            },
        methods:{
//            add : add // es5 写法
                add, // es6 写法
                add1 : calc.add,
                substric: calc.substict,
        },
        created(){

        }
    }

</script>


<style>
    /** 当前页面的css样式，写到这里，其中scoped表示这个里面的写的css代码 只是在当前页面上有效， 不会影响到其他组件页面 **/

    .red{
        color: red;
    }
</style>