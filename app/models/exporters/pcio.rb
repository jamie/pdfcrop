class Exporters::Pcio
  def initialize(source, params)
    @source = source
    @x, @y = [params[:cardX], params[:cardY]].map(&:to_i)

    @cardh = 160
    @cardw = (160*@x)/@y
  end

  def data
    @cards = []
    stringio = Zip::OutputStream.write_buffer do |zipfile|
      @source.each_front_jpg do |jpg, i|
        @cards << i
        zipfile.put_next_entry("userassets/face-#{i}.jpg")
        zipfile.write(jpg)
      end

      @source.each_back_jpg do |jpg, i|
        zipfile.put_next_entry("userassets/back-#{i}.jpg")
        zipfile.write(jpg)
      end

      zipfile.put_next_entry("widgets.json")
      zipfile.write(manifest.to_json)
    end

    stringio.string
  end

  def manifest
    [
      # Default hand block on an "empty" default table
      {
        "dragging": nil,
        "id": "hand",
        "type": "hand",
        "x": 50,
        "y": 820,
        "z": 1
      },
      # Import deck of cards from pdf extract
      {
        "faceTemplate": {
          "includeBorder": "heavy",
          "includeRadius": true,
          "objects": [
            {
              "type": "image",
              "value": "face",
              "valueType": "dynamic",
              "color": "white",
              "h": @cardh,
              "w": @cardw,
              "x": 0,
              "y": 0
            }
          ]
        },
        "backTemplate": {
          "includeBorder": "heavy",
          "includeRadius": true,
          "objects": [
            {
              "type": "image",
              "value": "back",
              "valueType": "dynamic",
              "color": "#840202",
              "h": @cardh,
              "w": @cardw,
              "x": 0,
              "y": 0
            }
          ]
        },
        "cardTypes": @cards.inject({}) { |hash, i|
          hash["card-#{i}"] = {
            "face": "package://userassets/face-#{i}.jpg",
            "back": "package://userassets/back-#{i}.jpg",
            "label": "Card #{i}"
          }
          hash
        },
        "id": "cab00d1e-0000-0000-0000-000000000000",
        "type": "cardDeck",
        "cardHeight": @cardh,
        "cardWidth": @cardw,
        "autoShuffle": true,
        "enlarge": true,
        "enlargeRotate": true,
        "showUnflipped": true,
        "snapAngles": [0, 90, 180, 270],
        "x": 214,
        "y": 223,
        "z": 2
      }
    ] + @cards.map { |i|
      {
        "id": "cab00d1e-0000-0000-0000-1#{i.to_s.rjust(11,"0")}",
        "type": "card",
        "cardType": "card-#{i}",
        "deck": "cab00d1e-0000-0000-0000-000000000000",
        "parent": nil,
        "x": 214,
        "y": 223,
        "z": 1000 + i
      }
    }
  end
end
