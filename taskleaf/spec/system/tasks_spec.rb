require 'rails_helper'

describe 'タスク管理機能', type: :system do
    let(:user_a){FactoryBot.create(:user, name:'UserA', email: 'a@example.com')}
    let(:user_b){FactoryBot.create(:user, name:'UserB', email: 'b@example.com')}
    let!(:task_a){FactoryBot.create(:task, name:'first task', user: user_a)}

    before do            # user A login
        visit login_path
        fill_in 'email', with: login_user.email
        fill_in 'password', with: login_user.password
        click_button 'ログイン'
    end

    shared_examples_for 'User Aが作成したタスクが表示される' do
        it{expect(page).to have_content 'first task'}
    end

    describe '一覧表示機能' do
        context 'User A ログインしている時' do
            let(:login_user){user_a}
            
            it_behaves_like 'User Aが作成したタスクが表示される'
        end

        context 'User B ログインしている時' do
            let(:login_user){user_b}

            it 'User Aが作成したタスクが表示されない' do
                # User Aが作成したタスクの名称が画面上に表示されないことを確認
                expect(page).to have_no_content 'first task' 
            end
        end
    end

    describe '詳細表示機能' do
        context 'User Aがログインしている時' do
            let(:login_user){user_a}

            before do
                visit task_path(task_a)
            end

            it_behaves_like 'User Aが作成したタスクが表示される'
        end
    end

    describe '新規作成機能' do
        let(:login_user){user_a}

        before do
            visit new_task_path
            fill_in '名称', with: task_name
            click_button '登録'
        end

        context '新規作成画面で名称を入力した時' do
            let(:task_name) {'新規作成のテストを書く'}

            it '正常に登録' do
                expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
            end
        end

        context '新規作成画面で名称を入力しなかった時' do
            let(:task_name){ '' }

            it 'エラー' do
                within '#error_explanation' do
                    expect(page).to have_content '名称を入力してください'
                end
            end
        end
    end
end