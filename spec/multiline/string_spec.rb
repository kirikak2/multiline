RSpec.describe Multiline::String do
  describe "#to_s" do

  end

  describe "#concat" do
    let(:text_1) do
<<EOF
11111
222
333
44
5
EOF
    end

    let(:text_2) do
<<EOF
aaa
bbb
ccc
EOF
    end

    let(:text_3) do
<<EOF
あああああ
いいいいい
ううううう
ええ
お
EOF
    end

    it { expect(Multiline::String.new(text_1).row).to eq(5) }
    it { expect(Multiline::String.new(text_1).col).to eq(5) }
    it { expect(Multiline::String.new(text_2).row).to eq(3) }
    it { expect(Multiline::String.new(text_2).col).to eq(3) }
    it { expect(Multiline::String.new(text_3).row).to eq(5) }
    it { expect(Multiline::String.new(text_3).col).to eq(10) }

    it {
      text = Multiline::String.new
      text2 = Multiline::String.new(text_1)
      expect(text.concat(text2)).to eq(
<<EOF
11111
222  
333  
44   
5    
EOF
      )
    }

    it {
      text = Multiline::String.new(text_1)
      text2 = Multiline::String.new(text_2)
      expect(text.concat(text2)).to eq(
<<EOF
11111   
222  aaa
333  bbb
44   ccc
5       
EOF
    )
      expect(text.buf).to eq([
        "11111   ",
        "222  aaa",
        "333  bbb",
        "44   ccc",
        "5       "
      ])
      expect(text.col).to eq(8)
      expect(text.row).to eq(5)
    }

    it {
      text = Multiline::String.new(text_1)
      text2 = Multiline::String.new(text_2)
      expect(text.concat(text2, align: :top)).to eq(
<<EOF
11111aaa
222  bbb
333  ccc
44      
5       
EOF
    )
      expect(text.buf).to eq([
        "11111aaa",
        "222  bbb",
        "333  ccc",
        "44      ",
        "5       "
      ])
      expect(text.col).to eq(8)
      expect(text.row).to eq(5)
    }

    it {
      text = Multiline::String.new(text_1)
      text2 = Multiline::String.new(text_2)
      expect(text.concat(text2, align: :bottom)).to eq(
<<EOF
11111   
222     
333  aaa
44   bbb
5    ccc
EOF
    )
      expect(text.buf).to eq([
        "11111   ",
        "222     ",
        "333  aaa",
        "44   bbb",
        "5    ccc",
      ])
      expect(text.col).to eq(8)
      expect(text.row).to eq(5)
    }

    it {
      text = Multiline::String.new(text_3)
      text2 = Multiline::String.new(text_2)
      expect(text.concat(text2)).to eq(
<<EOF
あああああ   
いいいいいaaa
うううううbbb
ええ      ccc
お           
EOF
    )
      expect(text.buf).to eq([
        "あああああ   ",
        "いいいいいaaa",
        "うううううbbb",
        "ええ      ccc",
        "お           "
      ])
      expect(text.col).to eq(13)
      expect(text.row).to eq(5)
    }

    it {
      text = Multiline::String.new(text_3)
      text2 = Multiline::String.new(text_2)
      expect(text.concat(text2, align: :top)).to eq(
<<EOF
あああああaaa
いいいいいbbb
うううううccc
ええ         
お           
EOF
    )
      expect(text.buf).to eq([
        "あああああaaa",
        "いいいいいbbb",
        "うううううccc",
        "ええ         ",
        "お           "
      ])
      expect(text.col).to eq(13)
      expect(text.row).to eq(5)
    }

    it {
      text = Multiline::String.new(text_3)
      text2 = Multiline::String.new(text_2)
      expect(text.concat(text2, align: :bottom)).to eq(
<<EOF
あああああ   
いいいいい   
うううううaaa
ええ      bbb
お        ccc
EOF
    )
      expect(text.buf).to eq([
        "あああああ   ",
        "いいいいい   ",
        "うううううaaa",
        "ええ      bbb",
        "お        ccc"
      ])
      expect(text.col).to eq(13)
      expect(text.row).to eq(5)
    }

    context "configure overwrite_display_width" do
      before(:all) { Multiline.config.display_width_overwrite = { "─".ord => 2 } }
      after(:all) { Multiline.config.display_width_overwrite = {} }

      let(:text_1) do
<<EOF
１
───
１＋２
EOF
      end

    let(:text_2) do
<<EOF
１
───
１＋２
EOF
    end

      it {
        text = Multiline::String.new(text_1)
        text2 = Multiline::String.new("＋")
        text3 = Multiline::String.new(text_2)
        text.concat(text2)
        text.concat(text3)
        expect(text.to_s).to eq(
<<EOF
１      １    
───＋───
１＋２  １＋２
EOF
        )
      }
    end
  end
end

