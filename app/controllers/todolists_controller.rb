class TodolistsController < ApplicationController
  def new
    @list = List.new
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def create
    list = List.new(list_params)
    list.save
    redirect_to todolist_path(list.id)
  end

  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to todolist_path(list.id)
  end


  # フォームからデータを送信するときは、「マスアサインメント脆弱性」というセキュリティ上の問題があります。
  # （簡単に伝えると、データ送信時に不正なリクエストによって、予期しない値を変更されてしまう脆弱性です）
  # Railsでは、この脆弱性を防ぐ「ストロングパラメータ」の仕組みが用意されています。
  # この仕組みがprivateの行から下のコードになります。
  private
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end

  # list_paramsの定義
  # list_paramsではフォームで入力されたデータを受け取っています。細かく見ていきましょう。
  # paramsはRailsで送られてきた値を受け取るためのメソッドです。
  # requireでデータのオブジェクト名(ここでは:list)を指定し、permitでキー（:title,:body）を指定しています。
  # これにより、list_paramsの中にフォームで入力されたデータが格納されます。

end
