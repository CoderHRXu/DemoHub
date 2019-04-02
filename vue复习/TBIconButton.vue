<style scoped lang="stylus">
  div
    position relative

  p
    margin-top: 10px
    margin-bottom: 10px

  .buttonImage
    position absolute
    left 50%
    transform translateX(-50%)
  .buttonText
    position absolute
    left 50%
    transform translateX(-50%)
    top 50%
</style>

<template>
  <div @click="tbIconBtnClick">
    <p class="buttonImage" :style="iconStyle"></p>
    <p class="buttonText" :style="titleStyle">{{this.titleStyle.title}}</p>
  </div>
</template>

<script>
  export default {
    name: "TBIconButton",

    data () {
      return {
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

      tbIconBtnClick () {
        console.log('点击TBiconButton');
        /*抛出事件和参数*/
        this.$emit('tbIconBtnClick', 'TB参数');
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
            fontSize: '20px',
            fontFamily: '微软雅黑',
            textAlign: 'center',
            title: '',
            "line-height": '100px',
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
            /*图片素材的高*/
            height: '40px',
            /*图片素材的宽*/
            width: '40px',
            /*图片素材的url eg:url(" + iconPath + ") no-repeat center ,path要用import或者require导入*/
            background: "",
          }
        }
      },
    }
  }


</script>

