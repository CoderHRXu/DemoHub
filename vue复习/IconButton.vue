<!--
xxxxxxxxx(描述)
路由：

@Author : haoran 
@DATE : 2019-03-22
-->
<style scoped lang="stylus">

  div
    position relative

  span
    // 文字外边距
    margin-left: 10px
    margin-right 10px
    position absolute
  i
    // 左右外边距 10px 根据需要调整
    margin-left: 10px
    margin-right 10px
    // 处理上下居中
    position: absolute
    top 50%
    transform translateY(-50%)
</style>

<template>
  <div @click="iconBtnClick">
    <i class="buttonImage" :style="iconStyle"></i>
    <span class="buttonText" @click="click" :style="titleStyle">{{this.titleStyle.title}}</span>
  </div>
</template>

<script>
  export default {


    name: "IconButton",

    data () {
      return {
        // background url("~@images/help/" + $name) no-repeat center


      }
    },
    created () {
    },
    computed: {},
    mounted () {
    },
    methods: {
      /********* 网络请求 *********/

      /********* 私有方法 *********/

      click () {
      },

      iconBtnClick () {
        console.log('点击iconButton');
        // 抛出事件和参数
        this.$emit('iconBtnClick', '参数');
      },
    },
    props: {

      /**
       * 文字样式
       */
      titleStyle: {
        type: Object,
        default: () => {
          return {
            // 字体大小
            fontSize: '20px',
            // 字体
            fontFamily: '微软雅黑',
            // 文字对齐方式
            textAlign: 'center',
            // 文字内容
            title: '',
            // 行高
            lineHeight: '100px',
          }
        }
      },

      /**
       * 图片样式
       */
      iconStyle: {
        type: Object,
        default: () => {
          return {
            // 图片素材的高
            height: '40px',
            // 图片素材的宽
            width: '40px',
            // 图片素材的url eg:url(" + iconPath + ") no-repeat center ,path要用import或者require导入
            background: "",
            // 左侧边距（左右二选一）eg:如左对齐 left 10% 竖直为边距，根据父控件的宽度计算
            left: "0%",
            // 右侧边距（左右二选一）eg:如右对齐 right 10% 竖直为边距，根据父控件的宽度计算
            right: "0%",

          }
        }
      },

    }
  }
</script>