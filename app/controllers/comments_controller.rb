class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_thought, only: [:show]

  def show
    @comment = Comment.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @thought = @comment.thought
    respond_to do |format|
      if @comment.save
        format.html { redirect_to root_path, notice: 'comment was successfully created.' }
        format.js
      else
        format.html { redirect_to root_path, alert: @comment.errors.full_messages.join('. ') }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @thought = @comment.thought

    respond_to { |format| format.js } if @comment.destroy
  end

  private

  def set_thought
    @thought = Thought.find(params[:thought_id])
  end

  def comment_params
    params.require(:comment).permit(:text, :user_id, :thought_id)
  end
end
