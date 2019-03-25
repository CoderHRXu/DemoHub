<!--
xxxxxxxxx(描述)
路由：

@Author : haoran 
@DATE : 2019-03-22
-->
<style scoped lang="stylus">

</style>

<template>
  <div>
    组件组件
    <i class="icon"></i>
    <span class="buttonText">{{text}}</span>
    <span>这是组件</span>
  </div>
</template>

<script>
  export default {
    name: "IconButton",

    data () {
      return {}
    },
    computed: {},
    mounted () {
    },
    methods: {
      /********* 网络请求 *********/

      /********* 私有方法 *********/
    },
    props: {
      iconName:{
        type: String
      },

      text:{
        type: String,
        default : ''
      }
    }
  }
</script>