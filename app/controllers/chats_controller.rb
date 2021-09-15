class ChatsController < ApplicationController
  def show
    @user = User.find(params[:id])
    # チャットする相手のidを取得
    rooms = current_user.user_rooms.pluck(:room_id)
    # 自分のidが入ったuser_roomテーブルのレコードのすべてのroom_idを取得
    # 自分がDMをしている人の数だけ配列で取得できる
    # 複数人とDMをしていてもすべて取得  
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms) 
    # UserRoomテーブルからuser_idが今からDMする相手のid、room_idに自分のidが入っているroomのidで検索
    # user_idが@user且つroom_idが上で取得したrooms配列の中にある数値のもののみを取得(1個 or 0個)

    if user_rooms.nil? # 既にDMしているかいないくかをチェック
      @room = Room.new
      @room.save
      # 新しいroomを作成して保存
      UserRoom.create(user_id: @user.id, room_id: @room.id)
      # @room.idと@user.idをUserRoomのカラムに保存(1レコード)
      UserRoom.create!(user_id: current_user.id, room_id: @room.id)
      # @room.idとcurrent_user.idをUserRoomのカラムに保存(1レコード)
    else
      @room = user_rooms.room
      # 既にDMしている場合は、@roomにuser_roomsに紐付いているroomテーブルのレコードを代入
      # DMをしているroomを取得して@roomに代入
    end
    
    @chats = @room.chats
    # if文の中で定義した@roomに紐づくchatsテーブルのレコードを代入
    # 今DMをしているroomに紐付いているchatsテーブルのレコードを代入(DMの会話の内容)
    @chat = Chat.new(room_id: @room.id)
    # いまDMしているroomのidを代入したChatテーブルの空のインスタンスを生成
    # ここで@room.idを代入しておいて、その@room.idをshow.html.erbのform_withでhidden_fieldを使いcreateアクションに送っている
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    redirect_back(fallback_location: root_path)
  end

  private
  
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end