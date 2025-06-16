module emotionexplorer::emotion_core;


public struct EmotionalRecord has key, store {
    id: UID,
    creator_address: address,
    post_id: vector<u8>,
    comment_id: vector<u8>,
    sentiment: u8,
    timestamp: u64,
    content_hash: vector<u8>
}

public fun record_sentiment(
    ctx: &mut tx_context::TxContext,
    creator_address: address,
    post_id: vector<u8>,
    comment_id: vector<u8>,
    sentiment: u8,
    content_hash: vector<u8>
) {
    // input validation
    assert!(sentiment <= 2, 0x01);
    assert!(vector::length(&post_id) > 0 && vector::length(&post_id) <= 64, 0x02);
    assert!(vector::length(&comment_id) > 0 && vector::length(&comment_id) <= 64, 0x03);
    assert!(vector::length(&content_hash) == 32, 0x04);

    // create record
    let record = EmotionalRecord {
        id: object::new(ctx),
        creator_address,
        post_id,
        comment_id,
        sentiment,
        timestamp: tx_context::epoch_timestamp_ms(ctx),
        content_hash
    };

    transfer::public_transfer(record, creator_address)
}