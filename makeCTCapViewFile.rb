#実行するとmotファイルを100%として各バージョンの容量がchart.js用に吐き出される

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
#■mapファイルからDバージョンとサイズの抽出
# D行の次にサイズが書いてあるのでその部分を抽出する
verAry = Array.new
motSizeArr = Array.new

#■各フォルダにアクセス
Dir.glob('*/*.map'){ |file|
  f = open(file) #ファイルオープン
  f.each do |line|
    if line =~ /^D/ then
      verAry.push(file.split("/")[-2])
      motSizeArr.push(f.readline.split(" ")[1])
      break
    end
  end
  f.close #ファイルクローズ
}

#■バージョンには"が必要なためあらかじめ足しておく
verAry.map!{ |item| "\"" + item + "\""}
#■サイズはパーセント表記に修正しておく
motSizeArr.map!{ |item| item.to_i(16).to_f/"0x400000".to_i(16).to_f }
#■ファイルサイズは予め整数になおしておく


#■graph.jsを作成しlabelとdataを入力

#■graph.jsの作成(テンプレート作成)
graph_js_text.gsub!('labels : []','labels : ['+ verAry.join(',') +']')
graph_js_text.gsub!('data : []','data : [' + motSizeArr.join(',') + ']')
File.open("graph.js","w") do |file|
  file.puts(graph_js_text)
end

File.open("test.js","w") do |file|
  file.puts('[' + verAry.join(',') + ']')
  file.puts
end
p verAry.join('aaa')
p motSizeArr
p "0x400000".to_i(16)
