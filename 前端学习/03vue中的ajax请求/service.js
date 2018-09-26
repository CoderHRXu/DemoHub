/**
 * Created by haoran on 2018/9/26.
 */
var Koa=require('koa');

var router = require('koa-router')();  /*引入是实例化路由** 推荐*/

//实例化
var app=new Koa();

router.get('/',async (ctx)=>{
    ctx.body="首页";

})

router.get('/news',async (ctx)=>{
    ctx.body="新闻列表页面";

})
//动态路由  http://localhost:3000/newscontent/xxxx
router.get('/newscontent/:aid',async (ctx)=>{

    //获取动态路由的传值

    console.log(ctx.params);  //{ aid: '456' }

ctx.body="新闻详情";

});


app.use(router.routes());   /*启动路由*/
app.use(router.allowedMethods());

app.listen(3000);
