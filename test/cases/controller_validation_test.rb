require 'test_helper'
require 'action_controller'

ActionController::Routing::Routes.draw do |map|
  map.connect ':controller/:action/:id'
end

class WidgetsController < ActionController::Base
  include ValidatesCaptcha::ControllerValidation
  
  validates_captcha :except => [:update, :save, :persist, :bingo]
  validates_captcha_of :widgets, :only => :update
  validates_captcha_of Widget, :only => [:save, :persist]
  
  def create
    begin
      Widget.new.save!
    rescue ActiveRecord::RecordInvalid
      @invalid = true
    end
    
    render :nothing => true
  end
  
  def update
    begin
      Widget.new.save!
    rescue ActiveRecord::RecordInvalid
      @invalid = true
    end
    
    render :nothing => true
  end
  
  def save
    encrypted = ValidatesCaptcha.encrypt_captcha_code('take this')
    decrypted = ValidatesCaptcha.decrypt_captcha_code(encrypted)
    
    begin
      Widget.create! :captcha => decrypted, :encrypted_captcha => encrypted
    rescue ActiveRecord::RecordInvalid
      @invalid = true
    end

    render :nothing => true
  end
  
  def store
    encrypted = ValidatesCaptcha.encrypt_captcha_code('take this')
    decrypted = ValidatesCaptcha.decrypt_captcha_code(encrypted) + 'ha!'
    
    begin
      Widget.create! :captcha => decrypted, :encrypted_captcha => encrypted
    rescue ActiveRecord::RecordInvalid
      @invalid = true
    end

    render :nothing => true
  end
  
  def persist
    encrypted = ValidatesCaptcha.encrypt_captcha_code('take this')
    decrypted = ValidatesCaptcha.decrypt_captcha_code(encrypted) + 'ha!'
    
    begin
      Widget.create! :captcha => decrypted, :encrypted_captcha => encrypted
    rescue ActiveRecord::RecordInvalid
      @invalid = true
    end

    render :nothing => true
  end
  
  def bingo
    begin
      Widget.new.save!
    rescue ActiveRecord::RecordInvalid
      @invalid = true
    end
    
    render :nothing => true
  end
end

class ControllerValidationTest < ActionController::TestCase
  tests WidgetsController
  
  test "defines a class level #validates_captcha method" do
    assert_respond_to WidgetsController, :validates_captcha
  end
  
  test "defines a class level #validates_captcha_of method" do
    assert_respond_to WidgetsController, :validates_captcha_of
  end
  
  test "calling #create method of controller should assign @invalid" do
    post :create
    assert_not_nil assigns(:invalid)
  end
  
  test "calling #update method of controller should assign @invalid" do
    post :update
    assert_not_nil assigns(:invalid)
  end
  
  test "calling #save method of controller should not assign @invalid" do
    post :save
    assert_nil assigns(:invalid)
  end
  
  test "calling #store method of controller should should assign @invalid" do
    post :store
    assert_not_nil assigns(:invalid)
  end
  
  test "calling #persist method of controller should should assign @invalid" do
    post :persist
    assert_not_nil assigns(:invalid)
  end
  
  test "calling #bingo method of controller should not assign @invalid" do
    post :bingo
    assert_nil assigns(:invalid)
  end
end
