class MemosController < ApplicationController
  before_action :set_memo, only: [:show, :edit, :update, :destroy]

  # GET /memos
  # GET /memos.json
  def index
    if loggen_in?
      @memos = current_user.memos
    else
      redirect_to gest_index_path
    end
  end

  # GET /memos/1
  # GET /memos/1.json
  def show
    if loggen_in?
      @comments = Comment.where(memo_id: params[:id])
    else
      redirect_to gest_index_path,notice: 'まずはログインしてみてね'
    end
  end

  # GET /memos/new
  def new
    if loggen_in?
      @memo = Memo.new
    else
      redirect_to gest_index_path
    end
  end

  # GET /memos/1/edit
  def edit
    if current_user.id != @memo.user_id
      redirect_to root_path, notice: '自分のものしか編集できないよ'
    end
  end

  # POST /memos
  # POST /memos.json
  def create
    @memo = Memo.new(memo_params)
    @memo.user = current_user

    respond_to do |format|
      if @memo.save
        format.html { redirect_to @memo, notice: 'Memo was successfully created.' }
        format.json { render :show, status: :created, location: @memo }
      else
        format.html { render :new }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memos/1
  # PATCH/PUT /memos/1.json
  def update
    respond_to do |format|
      if @memo.update(memo_params)
        format.html { redirect_to @memo, notice: 'Memo was successfully updated.' }
        format.json { render :show, status: :ok, location: @memo }
      else
        format.html { render :edit }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memos/1
  # DELETE /memos/1.json
  def destroy
    if current_user.id == @memo.user_id
      @memo.destroy
      respond_to do |format|
        format.html { redirect_to memos_url, notice: 'Memo was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path, notice: '自分のメモしか削除できないよ'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memo
      @memo = Memo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def memo_params
      params.require(:memo).permit(:title, :body, :image)
    end
end
