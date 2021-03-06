require 'spec_helper'

describe 'Page' do
  let(:fullscreen_page_id) { 'FullscreenInc' }

  describe '#posts' do
    let(:page) { Funky::Page.find(page_id) }
    let(:posts) { page.posts }

    context 'given an existing page ID was passed' do
      let(:page_id) { fullscreen_page_id }

      specify 'returns a list of posts' do
        post = posts.first

        expect(posts).to all be_a Funky::Post
        expect(post.type).to be_a String
        expect(post.created_time).to be_a DateTime
      end

      specify 'returns more than one page of posts' do
        expect(posts.count).to be > 100
      end

      specify 'includes the oldest post of the page' do
        expect(posts.map {|post| post.id}).to include '221406534569729_221415914568791'
      end
    end
  end

  describe '#posts with since option' do
    let(:page) { Funky::Page.find(page_id) }
    let(:posts) { page.posts(since: since_date) }

    context 'given an existing page ID and since date' do
      let(:page_id) { fullscreen_page_id }
      let(:since_date) { "2017-07-27" }

      specify 'returns the first post of since date as the last' do
        expect(posts.last.id).to eq('221406534569729_1516478451729191')
      end
    end
  end
end
