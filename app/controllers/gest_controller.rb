class GestController < ApplicationController
  def index
    @memos = Memo.all
  end
end
