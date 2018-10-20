'use strict';
import React from 'react';
import {
    Platform,
    AppRegistry,
    StyleSheet,
    Text,
    FlatList,
    Image,
    Dimensions,
    Alert,
    TouchableOpacity,
    View
} from 'react-native';


var NativeVC = require('react-native').NativeModules.ProjectViewController;


var Windwidth = Dimensions.get('window').width;//获取屏幕宽度

var imagwiith = (Windwidth - 20) / 3; //image宽度
class RNHighScores extends React.Component {
    //构造器
    constructor(props) {
        super(props);
        //当前页
        this.page = 1
        this.state = {
            dataArray: [],
            load: false,
            //下啦刷新
            isRefresh: false,
            //加载更多
            isLoadMore: false,
        };
        // 在ES6中，如果在自定义的函数里使用了this关键字，则需要对其进行“绑定”操作，否则this的指向会变为空
        // 像下面这行代码一样，在constructor中使用bind是其中一种做法（还有一些其他做法，如使用箭头函数等）
        this.fetchData = this.fetchData.bind(this);


    }
    //flatlist分割线
    _separator = () => {
        return <View style={{ height: 2, backgroundColor: 'blue' }} />
    };

   // http://service.store.dandanjiang.tv/v1/wallpaper/resource?category_id=4e4d610cdf714d2966000003&height=1136&limit=20&skip=0&sys_language=zh-Hans-CN&width=640
    //网络加载
    fetchData() {
        fetch("http://service.store.dandanjiang.tv/v1/wallpaper/resource?category_id=4e4d610cdf714d2966000003&height=1136&limit=20&skip=" + this.page + "&sys_language=zh-Hans-CN&width=640")
            .then((response) => response.json())

            .then((responseData) => {
                if (this.page === 1) {
                    //console.log("重新加载")
                    //console.log(responseData.data.list);
                    // 注意，这里使用了this关键字，为了保证this在调用时仍然指向当前组件，我们需要对其进行“绑定”操作
                    this.setState({
                        load: true,
                        dataArray: responseData.res.data,
                    });

                } else {
                    //console.log("加载更多")

                    this.setState({
                        // 加载更多 这个变量不刷新
                        isLoadMore: false,
                        // 数据源刷新 add
                        dataArray: this.state.dataArray.concat(responseData.res.data),
                    });
                }
            });
    };



    //上啦刷新
    _onRefresh = () => {
        if (!this.state.isRefresh) {
            this.state = {
                dataArray: []
            };
            this.page = 1
            this.fetchData()
            console.log("刷新" + this.page)
        }
    };


    //加载更多
    _onLoadMore = () => {
        // 不处于正在加载更多 && 有下拉刷新过，因为没数据的时候 会触发加载
        if (!this.state.isLoadMore && this.state.dataArray.length > 0) {
            this.page = this.page + 20
            this.fetchData()
            console.log("加载更多" + this.page)
        }
    };

    //耗时加载放在这里
    componentDidMount() {
        this.fetchData();

    };

    render() {
        if (!this.state.load) {
            return <Text>加载中...</Text>
        }
        return (this.renderView(this.state.dataArray));
    };


    //flatlist布局
    renderView() {
        return (
            <View style={{ flex: 1 }}>
                <FlatList

                    data={this.state.dataArray}
                    //es6写法,es5写法:this.renderRow
                    renderItem={this.renderRow.bind(this)}
                    //头部试图
                    // ListHeaderComponent={this.listHeaderComponet}
                    //分割线
                    //ItemSeparatorComponent={this._separator}
                    //下拉刷新
                    onRefresh={() => this._onRefresh()}
                    refreshing={this.state.isRefresh}
                    //加载更多
                    onEndReached={() => this._onLoadMore()}

                    onEndReachedThreshold={0.1}
                    //多列布局
                    numColumns={3}
                    //多列布局分割线
                    //columnWrapperStyle={{borderWidth:2,borderColor:'black',paddingLeft:20}}
                    keyExtractor={this.keyExtractor}
                />
            </View>
        );

    };


    keyExtractor(item: Object, index: number) {
        return item.thumb
    };

    //item布局
    renderRow({ item, index }) {
        return (
            <TouchableOpacity onPress={this.cellAction.bind(this,item,index)}>
            <Image
                source={{ uri: item.thumb}}
                style={styles.thumbnail}
            />
             </TouchableOpacity>
        )
    };

    //item点击事件
    cellAction =(item,index)=>{

   NativeVC.doSomething(index,this.state.dataArray);
      

   
   };

}
//布局
const styles = StyleSheet.create({
    container: {

    },
    //falitlist中的image控件布局
    thumbnail: {
        width: imagwiith,
        height: imagwiith * 1.5,
        //圆角
        borderRadius: 10,
        marginTop: 2.5,
        marginLeft: 5,
        marginBottom: 2.5,

    }

});
// Module name(此处是自定义rn组键名字,ios原生代码中需要用到)
AppRegistry.registerComponent('RNHighScores', () => RNHighScores);