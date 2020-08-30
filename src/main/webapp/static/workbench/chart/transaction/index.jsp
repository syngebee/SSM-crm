<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%--
         需求：
                根据交易表中的不同阶段的数量进行一个统计
                最终形成一个漏斗图（倒三角）
                将统计出来的阶段数量比较高的，往上面排列
                将统计出来的阶段数量比较少的，往下面排列
--%>
<head>
    <title>transactionChat</title>
    <script src="/static/ECharts/echarts.min.js"></script>
    <script src="/static/jquery/jquery-1.11.1-min.js"></script>
    <style>
        #main{
            text-align: center;
            background-color: #fff;
            border-radius: 20px;
            width: 300px;
            height: 350px;
            margin: auto;
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
        }
    </style>
    <script>
        $(function () {
            getCharts();
        });
        
        function getCharts() {

            $.ajax({
                url:"/Tran/getCharts",
                type:"get",
                data:"",
                dataType:"json",
                success:function (data) {

                    let myChart = echarts.init(document.getElementById("main"));
                    let option;
                    option = {
                        title: {
                            text: '交易漏斗图',
                            subtext: '统计交易阶段的漏斗图'
                        },
                        toolbox: {
                            feature: {
                                dataView: {readOnly: false},
                                restore: {},
                                saveAsImage: {}
                            }
                        },
                        series: [
                            {
                                name:'交易漏斗图',
                                type:'funnel',
                                left: '10%',
                                top: 60,
                                //x2: 80,
                                bottom: 60,
                                width: '80%',
                                // height: {totalHeight} - y - y2,
                                min: 0,
                                max: data.total,
                                minSize: '0%',
                                maxSize: '100%',
                                sort: 'descending',
                                gap: 2,
                                label: {
                                    show: true,
                                    position: 'inside'
                                },
                                labelLine: {
                                    length: 10,
                                    lineStyle: {
                                        width: 1,
                                        type: 'solid'
                                    }
                                },
                                itemStyle: {
                                    borderColor: '#fff',
                                    borderWidth: 1
                                },
                                emphasis: {
                                    label: {
                                        fontSize: 20
                                    }
                                },
                                data:data.dataList
                               /* [
                                    {value: 60, name: '访问'},
                                    {value: 40, name: '咨询'},
                                    {value: 20, name: '订单'},
                                    {value: 80, name: '点击'},
                                    {value: 100, name: '展现'}
                                ]*/
                            }
                        ]
                    };
                    myChart.setOption(option);
                },
                error:function () {}
            });






        }
    </script>
</head>
<body>
    <div id="main" style="width:600px;height:400px;" ></div>
</body>
</html>
