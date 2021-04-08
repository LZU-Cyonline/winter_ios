// pages/testtesttest/testtesttest.js
var app = getApp()
Page({

	/**
	 * 页面的初始数据
	 */
	data: {
		template: {},
	},

	/**
	 * 生命周期函数--监听页面加载
	 */
	onLoad() {
		wx.showLoading({
			title: '生成分享图片中',
		})
		
		// var avatarurl = app.globalData.avatarurl
		// console.log(avatarurl)
		// var book_name = app.globalData.book_name
		// var nickname = app.globalData.nickname
		// var continuenum = app.globalData.continuenum
		// var totalnum = app.globalData.totalnum
		// var comment = app.globalData.comment
		// var views = [{
		// 		"type": "rect",
		// 		"css": {
		// 			"background": "#fff",
		// 			"width": "654px",
		// 			"height": "1200px",
		// 			"top": "37px",
		// 			"left": "37px",
		// 			"rotate": "0",
		// 			"borderRadius": "",
		// 			"shadow": "",
		// 			"color": "#fff"
		// 		}
		// 	},
		// 	{
		// 		"type": "text",
		// 		"text": "十百阅读",
		// 		"css": {
		// 			"color": "#000000",
		// 			"background": "rgba(0,0,0,0)",
		// 			"width": "284.5249938964844px",
		// 			"height": "71.49999999999999px",
		// 			"top": "68px",
		// 			"left": "214px",
		// 			"rotate": "0",
		// 			"borderRadius": "",
		// 			"borderWidth": "",
		// 			"borderColor": "#000000",
		// 			"shadow": "",
		// 			"padding": "0px",
		// 			"fontSize": "50px",
		// 			"fontWeight": "bold",
		// 			"maxLines": "2",
		// 			"lineHeight": "72.15000000000002px",
		// 			"textStyle": "fill",
		// 			"textDecoration": "none",
		// 			"fontFamily": "pingfang",
		// 			"textAlign": "center"
		// 		}
		// 	},
		// 	{
		// 		"type": "image",
		// 		"url": avatarurl,
		// 		"css": {
		// 			"width": "164.7624969482422px",
		// 			"height": "164.7624969482422px",
		// 			"top": "146px",
		// 			"left": "63px",
		// 			"rotate": "0",
		// 			"borderRadius": "82.3812484741211px",
		// 			"borderWidth": "",
		// 			"borderColor": "#000000",
		// 			"shadow": "",
		// 			"mode": "scaleToFill"
		// 		}
		// 	},
		// 	{
		// 		"type": "text",
		// 		"text": nickname,
		// 		"css": {
		// 			"color": "#000000",
		// 			"background": "rgba(0,0,0,0)",
		// 			"width": "97.52499389648438px",
		// 			"height": "42.89999999999999px",
		// 			"top": "328px",
		// 			"left": "92px",
		// 			"rotate": "0",
		// 			"borderRadius": "",
		// 			"borderWidth": "",
		// 			"borderColor": "#000000",
		// 			"shadow": "",
		// 			"padding": "0px",
		// 			"fontSize": "30px",
		// 			"fontWeight": "normal",
		// 			"maxLines": "2",
		// 			"lineHeight": "43.290000000000006px",
		// 			"textStyle": "fill",
		// 			"textDecoration": "none",
		// 			"fontFamily": "pingfang",
		// 			"textAlign": "center"
		// 		}
		// 	},
		// 	{
		// 		"type": "text",
		// 		"text": "书目:《" + book_name + "》",
		// 		"css": {
		// 			"color": "#000000",
		// 			"background": "rgba(0,0,0,0)",
		// 			"width": "400px",
		// 			"height": "44px",
		// 			"top": "160px",
		// 			"left": "270px",
		// 			"rotate": "0",
		// 			"borderRadius": "",
		// 			"borderWidth": "",
		// 			"borderColor": "#000000",
		// 			"shadow": "",
		// 			"padding": "0px",
		// 			"fontSize": "34px",
		// 			"fontWeight": "normal",
		// 			"maxLines": "1",
		// 			"lineHeight": "43.290000000000006px",
		// 			"fontFamily": "pingfang",
		// 			"textAlign": "left",
		// 			"text-overflow": "ellipsis",
		// 			"word-wrap": "break-word",
		// 			"white-space": "nowrap",
		// 			"overflow": "hidden"
		// 		}
		// 	},
		// 	{
		// 		"type": "text",
		// 		"text": "连续打卡：" + continuenum + "天",
		// 		"css": {
		// 			"color": "#000000",
		// 			"background": "rgba(0,0,0,0)",
		// 			"width": "350px",
		// 			"height": "44px",
		// 			"top": "235px",
		// 			"left": "270px",
		// 			"rotate": "0",
		// 			"borderRadius": "",
		// 			"borderWidth": "",
		// 			"borderColor": "#000000",
		// 			"shadow": "",
		// 			"padding": "0px",
		// 			"fontSize": "32px",
		// 			"fontWeight": "normal",
		// 			"maxLines": "2",
		// 			"lineHeight": "43.290000000000006px",
		// 			"textStyle": "fill",
		// 			"textDecoration": "none",
		// 			"fontFamily": "pingfang",
		// 			"textAlign": "left"
		// 		}
		// 	},
		// 	{
		// 		"type": "text",
		// 		"text": "累计打卡：" + totalnum + "天",
		// 		"css": {
		// 			"color": "#000000",
		// 			"background": "rgba(0,0,0,0)",
		// 			"width": "350px",
		// 			"height": "44px",
		// 			"top": "310px",
		// 			"left": "270px",
		// 			"rotate": "0",
		// 			"borderRadius": "",
		// 			"borderWidth": "",
		// 			"borderColor": "#000000",
		// 			"shadow": "",
		// 			"padding": "0px",
		// 			"fontSize": "32px",
		// 			"fontWeight": "normal",
		// 			"maxLines": "2",
		// 			"lineHeight": "43.290000000000006px",
		// 			"textStyle": "fill",
		// 			"textDecoration": "none",
		// 			"fontFamily": "pingfang",
		// 			"textAlign": "left"
		// 		}
		// 	},
		// 	{
		// 		"type": "rect",
		// 		"css": {
		// 			"background": "#5dbe8a",
		// 			"width": "670px",
		// 			"height": "2px",
		// 			"top": "387px",
		// 			"left": "31px",
		// 			"rotate": "0",
		// 			"borderRadius": "",
		// 			"shadow": "",
		// 			"color": "#5dbe8a"
		// 		}
		// 	},
		// 	{
		// 		"type": "text",
		// 		"text": "读书感悟/摘抄：",
		// 		"css": {
		// 			"color": "#000000",
		// 			"background": "rgba(0,0,0,0)",
		// 			"width": "317.5249938964843px",
		// 			"height": "42.89999999999999px",
		// 			"top": "410px",
		// 			"left": "13px",
		// 			"rotate": "0",
		// 			"borderRadius": "",
		// 			"borderWidth": "",
		// 			"borderColor": "#000000",
		// 			"shadow": "",
		// 			"padding": "0px",
		// 			"fontSize": "34px",
		// 			"fontWeight": "normal",
		// 			"maxLines": "2",
		// 			"lineHeight": "43.290000000000006px",
		// 			"textStyle": "fill",
		// 			"textDecoration": "none",
		// 			"fontFamily": "pingfang",
		// 			"textAlign": "center"
		// 		}
		// 	},
		// 	{
		// 		"type": "text",
		// 		"text": comment,
		// 		"css": {
		// 			"color": "#000000",
		// 			"background": "rgba(0,0,0,0)",
		// 			"width": "625px",
		// 			"height": "351.78px",
		// 			"top": "472px",
		// 			"left": "52.51999999999998px",
		// 			"rotate": "0",
		// 			"borderRadius": "",
		// 			"borderWidth": "",
		// 			"borderColor": "#000000",
		// 			"shadow": "",
		// 			"padding": "0px",
		// 			"fontSize": "26px",
		// 			"fontWeight": "normal",
		// 			"maxLines": "17",
		// 			"lineHeight": "28.860000000000007px",
		// 			"textStyle": "fill",
		// 			"textDecoration": "none",
		// 			"fontFamily": "pingfang",
		// 			"textAlign": "center"
		// 		}
		// 	},
		// 	{
		// 		"type": "image",
		// 		"url": '/static/images/erweima.jpg',
		// 		"css": {
		// 			"color": "#000000",
		// 			"background": "#ffffff",
		// 			"width": "200px",
		// 			"height": "200px",
		// 			"top": "853px",
		// 			"left": "268px",
		// 			"rotate": "0",
		// 			"borderRadius": ""
		// 		}
		// 	},
		// 	{
		// 		"type": "text",
		// 		"text": "扫描二维码，和我一起打卡吧！",
		// 		"css": {
		// 			"color": "#000000",
		// 			"background": "rgba(0,0,0,0)",
		// 			"width": "436px",
		// 			"height": "42.89999999999999px",
		// 			"top": "1084px",
		// 			"left": "166.51999999999998px",
		// 			"rotate": "0",
		// 			"borderRadius": "",
		// 			"borderWidth": "",
		// 			"borderColor": "#000000",
		// 			"shadow": "",
		// 			"padding": "0px",
		// 			"fontSize": "30px",
		// 			"fontWeight": "normal",
		// 			"maxLines": "17",
		// 			"lineHeight": "43.290000000000006px",
		// 			"textStyle": "fill",
		// 			"textDecoration": "none",
		// 			"fontFamily": "pingfang",
		// 			"textAlign": "center"
		// 		}
		// 	}
		// ]
		
		// var template = {
		// 	"width": "720px",
		// 	"height": "1280px",
		// 	"background": "#5dbe8a",
		// 	"views": views
		// }
		this.setData({
			template: app.globalData.template,
			load: 0
		})
	},

	/**
	 * 生命周期函数--监听页面初次渲染完成
	 */
	onReady: function() {

	},

	/**
	 * 生命周期函数--监听页面显示
	 */
	onShow: function() {

	},

	/**
	 * 生命周期函数--监听页面隐藏
	 */
	onHide: function() {

	},

	/**
	 * 生命周期函数--监听页面卸载
	 */
	onUnload: function() {

	},

	/**
	 * 页面相关事件处理函数--监听用户下拉动作
	 */
	onPullDownRefresh: function() {

	},

	/**
	 * 页面上拉触底事件的处理函数
	 */
	onReachBottom: function() {

	},
	onImgOK(e) {
		this.imagePath = e.detail.path;
		this.setData({
			image: e.detail.path
		})
		wx.hideLoading();
		wx.showToast({
			icon:'none',
			title:'保存后图片将为正常尺寸',
			duration:3000
		})
		console.log(e);
	},
	saveImage() {
		wx.showLoading({
			title: '正在保存...',
		})
		var that = this
		wx.getSetting({
			success(res) {
				if (!res.authSetting['scope.writePhotosAlbum']) {
					wx.authorize({
						scope: 'scope.writePhotosAlbum',
						success() {
							wx.saveImageToPhotosAlbum({
								filePath: that.data.image,
								success() {
									wx.showToast({
										title: '已保存',
										icon: 'success',
										duration: 2000
									})
								}
							});
						}
					})
				} else { //用户已授权，保存到相册
					wx.saveImageToPhotosAlbum({
						filePath: that.data.image,
						success() {
							wx.showToast({
								title: '已保存',
								icon: 'success',
								duration: 2000
							})
						}
					})
				}
			}
		})
	},



	/**
	 * 用户点击右上角分享
	 */
	onShareAppMessage: function() {

	}
})
