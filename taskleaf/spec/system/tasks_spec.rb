require 'rails_helper'

describe 'タスク管理機能', type: :system do
    describe '一覧表示機能' do
        let(:user_a){FactoryBot.create(:user, name:'UserA', email: 'a@example.com')}
        let(:user_b){FactoryBot.create(:user, name:'UserB', email: 'b@example.com')}
        before do
            # user A のタスク作成
            FactoryBot.create(:task, name: 'first task', user: user_a)

            # user A login
            visit login_path
            fill_in 'email', with: login_user.email
            fill_in 'password', with: login_user.password
            click_button 'ログイン'
            
        end
        context 'User A ログインしている時' do
            let(:login_user){user_a}

            it 'User Aが作成したタスクが表示される' do
                # 作成すみのタスクの名称が画面上に表示されていることを確認
                expect(page).to have_content 'first task'
            end
        end

        context 'User B ログインしている時' do
            let(:login_user){user_b}

            it 'User Aが作成したタスクが表示されない' do
                # User Aが作成したタスクの名称が画面上に表示されないことを確認
                expect(page).to have_no_content 'first task' 
            end
        end

    end
end