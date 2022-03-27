require 'rails_helper'

describe 'タスク管理機能', type: :system do
    describe '一覧表示機能' do
        before do
            # user A 作成
            user_a = FactoryBot.create(:user, name: 'UserA', email: 'a@example.com')
            # user A のタスク作成
            FactoryBot.create(:task, name: 'first task', user: user_a)

            # user A login
            visit login_path
            fill_in 'email', with: 'a@example.com'
            fill_in 'password', with: 'password'
            click_button 'ログイン'
            
        end
        context 'User A ログインしている時' do
            before do
            end

            it 'User Aが作成したタスクが表示される' do
                # 作成すみのタスクの名称が画面上に表示されていることを確認
                expect(page).to have_content 'first task'
            end
        end

        context 'User B ログインしている時' do
            before do
                # user B 作成
                FactoryBot.create(:user, name: 'UserB', email: 'b@example.com')
                # user B login
                visit login_path
                fill_in 'email', with: 'b@example.com'
                fill_in 'password', with: 'password'
                click_button 'ログイン'
            end

            it 'User Aが作成したタスクが表示されない' do
                # User Aが作成したタスクの名称が画面上に表示されないことを確認
                expect(page).to have_no_content 'first task' 
            end
        end

    end
end