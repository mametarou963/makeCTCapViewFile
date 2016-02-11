#graph.js用のテキスト(固定)
graph_js_text = <<"EOS"
var lineChartData = {
  labels : [],
  datasets : [
    {
      fillColor : "rgba(220,220,220,0.5)",
      strokeColor : "rgba(220,220,220,1)",
      pointColor : "rgba(220,220,220,1)",
      pointStrokeColor : "#fff",
      data : []
    }
  ]
}
var myLine = new Chart(document.getElementById("line").getContext("2d")).Line(lineChartData);
EOS

#main
#■graph.jsの作成(テンプレート作成)
File.open("graph.js","w") do |file| file.puts(graph_js_text) end


#■mapファイルからDバージョンとサイズの抽出
# D行の次にサイズが書いてあるのでその部分を抽出する
verAry = Array.new
motSizeArr = Array.new
f = open("Ver5.20/MF-CT1.map") #ファイルオープン
f.each do |line|
  if line =~ /^D/ then
    motSizeArr.push(f.readline.split(" ")[1])
    break
  end
end
f.close #ファイルクローズ

#■サイズの抽出
p motSizeArr
p "0x400000".to_i(16)


#■
p Dir.glob('*/*.map')
