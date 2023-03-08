class ReactionsController < ApplicationController
  def create
    @reaction = current_user.reactions.new reaction_params
    if @reaction.save
      render :create
    else
      flash[:error] = @reaction.errors.messages
      render_post_error
    end
  end

  def destroy
    @reaction = current_user.reactions.find_by(id: params[:id])
    if @reaction.destroy
      render :destroy
    else
      flash[:error] = @reaction.errors.messages
      render_post_error
    end
  end

  def render_post_error(post_id)
    render template: "posts/error",
           locals: { post_id: @reaction.ta_duty_type == "Post" ? @reaction.ta_duty_id : @reaction.ta_duty.post_id }
  end

  private

  def reaction_params
    params.require(:reaction).permit(:ta_duty_id, :ta_duty_type)
  end
end
