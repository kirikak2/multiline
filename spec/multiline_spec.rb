RSpec.describe Multiline do
  it "has a version number" do
    expect(Multiline::VERSION).not_to be nil
  end

  describe Multiline::String do
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
        expect(text.col).to eq(13)
        expect(text.row).to eq(5)
      }
    end
  end
end
