//index.js
import CanvasDrag from '../canvas-drag/canvas-drag';
var app=getApp()
Page({
  data: {
    graph: {},
    images: [{
        id: 0,
        title: '啦啦操一',
        url: 'https://cyonlineimg.chen517.xyz/啦啦操男.png',
        path: undefined
      },
      {
        id: 1,
        title: '啦啦操二',
        url: 'https://cyonlineimg.chen517.xyz/啦啦操女1.png',
        path: undefined
      },
      {
        id: 2,
        title: '校运会一',
        url: 'https://cyonlineimg.chen517.xyz/跑步1.png',
        path: undefined
      },
      {
        id: 3,
        title: '校运会二',
        url: 'https://cyonlineimg.chen517.xyz/校运会男.png',
        path: undefined
      },
      {
        id: 4,
        title: '十佳歌手一',
        url: 'https://cyonlineimg.chen517.xyz/十佳歌手海报男.png',
        path: undefined
      },
      {
        id: 5,
        title: '十佳歌手二',
        url: 'https://cyonlineimg.chen517.xyz/十佳歌手海报女1.png',
        path: undefined
      },
      {
        id: 6,
        title: '五四合唱一',
        url: 'https://cyonlineimg.chen517.xyz/五四合唱男.png',
        path: undefined
      },
      {
        id: 7,
        title: '五四合唱二',
        url: 'https://cyonlineimg.chen517.xyz/五四合唱女.png',
        path: undefined
      }
    ],
    show_img: false,
    current_image: undefined,
    add_img_path: undefined,
    show_model:false,
    image_data: {
        id: 0,
        title: '啦啦操一',
        url: 'https://cyonlineimg.chen517.xyz/啦啦操男.png',
        path: undefined
      },
    title: '啦啦操一',
    current:0,
	windowHeight:undefined,
	statusBarHeight:undefined,
	naviBarHeight:undefined,
	screenHeight:undefined
  },
  onLoad(){
	this.setData({
		windowHeight:app.globalData.windowHeight,
		statusBarHeight:app.globalData.statusBarHeight,
		naviBarHeight:app.globalData.naviBarHeight,
		screenHeight:app.globalData.screenHeight
	})  
	console.log(this.data.windowHeight)
	this.onChangeBgColor()
  },
  onChangeBgColor(){
    CanvasDrag.changeBgColor('#eeeeee');
  },
  chooseImage() {
    console.log('')
    var that=this
    wx.showModal({
      title: '提示',
      content: '选择模板会清空画布，确定要选择吗？',
      success(res){
        if(res.confirm){
          that.setData({
            show_img: false,
            show_model: true,
          })
          that.onClearCanvas()
        }
      }
    })

   
  },
  showImage() {
    this.setData({
      show_img: !this.data.show_img
    })
  },
  /**
   * 添加测试图片
   */
  show() {
    console.log(this.data.graph)
    let _this = this
    console.log(_this.data.canvasBg)
  },
  onAddTest() {
    this.setData({
      graph: {
        w: 120,
        h: 120,
        type: 'image',
        url: '../images/五四合唱女.png',
      }
    });
  },

  /**
   * 添加图片
   */
  // onAddImage() {
  //   wx.chooseImage({
  //     success: (res) => {
  //       console.log(res)
  //       this.setData({
  //         graph: {
  //           w: 200,
  //           h: 200,
  //           type: 'image',
  //           url: res.tempFilePaths[0],
  //         }
  //       });
  //     }
  //   })
  // },
  onAddImage() {
    wx.chooseImage({
      success: (res) => {
        console.log(res)
        this.setData({
          add_img_path: res.tempFilePaths[0]
        });
      }
    })
  },
  getUserImageInfo(e) {
    console.log(e)
    this.setData({
      graph: {
        w: app.globalData.windowWidth,
        h: app.globalData.windowWidth * e.detail.height / e.detail.width,
        type: 'image',
        url: this.data.add_img_path,
      }
    });
  },
  /**
   * 添加文本
   */
  onAddText() {
    this.setData({
      graph: {
        type: 'text',
        text: 'helloworld',
      }
    });
  },

  /**
   * 导出图片
   */
  onExport() {
    wx.showLoading({
      title: '生成中',
    })
    var that=this
    var model_dict = {
      h: app.globalData.windowWidth/750*1088,
      rotate: 0,
      sourceId: null,
      type: "image",
      url: that.data.current_image,
      w: app.globalData.windowWidth,
      x: 0,
      y: 0,
      man_add:true
    }

    CanvasDrag.exportJson()
      .then((imgArr) => {
        console.log(imgArr)
        var linshi=imgArr
        linshi.push(model_dict)
        CanvasDrag.initByArr(linshi);
        setTimeout(function(
          
        ) {
          CanvasDrag.export()
          .then((filePath) => {
            console.log(filePath);
            wx.previewImage({
              urls: [filePath],
              success(){
                console.log(linshi.pop())
                CanvasDrag.initByArr(linshi);
                wx.hideLoading()
              }
            })
          })
          .catch((e) => {
            console.error(e);
          })},1000)
        
      })
      .catch((e) => {
        console.error(e);
      });

    // CanvasDrag.initByArr(temp_theme);
    // CanvasDrag.export()
    //   .then((filePath) => {
    //     console.log(filePath);
    //     wx.previewImage({
    //       urls: [filePath]
    //     })
    //   })
    //   .catch((e) => {
    //     console.error(e);
    //   })
  },

  /**
   * 改变文字颜色
   */
  onChangeColor() {
    CanvasDrag.changFontColor('blue');
  },

  /**
   * 改变背景颜色
   */
 

  /**
   * 改变背景照片
   */
  onChangeBgImage() {
    CanvasDrag.changeBgImage('../images/五四合唱女.png');
  },

  /**
   * 导出当前画布为模板
   */
  onExportJSON() {
    CanvasDrag.exportJson()
      .then((imgArr) => {
        console.log(imgArr)
        console.log(JSON.stringify(imgArr));
      })
      .catch((e) => {
        console.error(e);
      });
  },

  onImport() {
    // 有背景
    // let temp_theme = [{"type":"bgColor","color":"yellow"},{"type":"image","url":"../../assets/images/test.jpg","y":98.78423143832424,"x":143.78423143832424,"w":104.43153712335152,"h":104.43153712335152,"rotate":-12.58027482265038,"sourceId":null},{"type":"text","text":"helloworld","color":"blue","fontSize":24.875030530031438,"y":242.56248473498428,"x":119.57012176513672,"w":116.73966979980469,"h":34.87503053003144,"rotate":8.873370699754087}];
    // 无背景
    let temp_theme = [{
      "type": "image",
      "url": "../../assets/images/test.jpg",
      "y": 103,
      "x": 91,
      "w": 120,
      "h": 120,
      "rotate": 0,
      "sourceId": null
    }, {
      "type": "text",
      "text": "helloworld",
      "color": "blue",
      "fontSize": 20,
      "y": 243,
      "x": 97,
      "rotate": 0
    }];

    CanvasDrag.initByArr(temp_theme);
  },

  onClearCanvas: function(event) {
    let _this = this;
    _this.setData({
      canvasBg: null
    });
    CanvasDrag.clearCanvas();
  },

  onUndo: function(event) {
    CanvasDrag.undo();
  },
  chooseModel: function (e) {
    console.log(e)
    console.log(e.detail.current)
    console.log(this.data.images[e.detail.current].url)
    this.setData({
      image_data: this.data.images[e.detail.current],
      title: this.data.images[e.detail.current].title

    })
    console.log(this.data.image_data)
  },
  confirmModel: function () {
    var that = this
    wx.showLoading({
      title: '加载中',
    })
    wx.downloadFile({
      url: that.data.image_data.url,
      success(res) {
        if (res.statusCode === 200) {
          console.log(res.tempFilePath)
          that.setData({
            current_image:res.tempFilePath,
            show_img:true,
            show_model:false,
          })
          wx.hideLoading({
            success: (res) => { },
          })
        }
        else {
          wx.hideLoading({
            success: (res) => { },
          })
          wx.showToast({
            title: '加载失败，请重试',
            icon: 'none'
          })
          console.log(res)
        }
      },
      fail(res) {
        console.log(res)
        wx.showToast({
          title: '加载失败，请重试',
          icon: 'none'
        })
      },
    })
  },
  cancelChoose(){
    console.log(1)
    this.setData({
      show_model:false
    })
  },
  nothing(){
    console.log('I do nothing')
  },
  nextModel(){
    this.setData({
      current: this.data.current == 7 ? 0 : this.data.current + 1
    })
  },
  beforeModel(){
    this.setData({
      current: this.data.current == 0 ? 7 : this.data.current - 1
    })
  }
});