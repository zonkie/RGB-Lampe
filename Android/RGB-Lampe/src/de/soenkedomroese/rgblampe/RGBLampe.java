package de.soenkedomroese.rgblampe;

import de.soenkedomroese.rgblampe.R;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.SeekBar;
import android.widget.TextView;

public class RGBLampe extends Activity {

	/* Get Default Adapter */
	private BluetoothAdapter _bluetooth = BluetoothAdapter.getDefaultAdapter();

	/* request BT enable */
	private static final int REQUEST_ENABLE = 0x1;
	/* request BT discover */
	private static final int REQUEST_DISCOVERABLE = 0x2;

	/** Called when the activity is first created. */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
	}

	public void onClickSetColorListener(final View view) {
		EditText SetRed = (EditText) findViewById(R.id.redNum);
		EditText SetGreen = (EditText) findViewById(R.id.greenNum);
		EditText SetBlue = (EditText) findViewById(R.id.blueNum);

		SeekBar SeekRed = (SeekBar) findViewById(R.id.seekBarRed);
		SeekBar SeekGreen = (SeekBar) findViewById(R.id.seekBarGreen);
		SeekBar SeekBlue = (SeekBar) findViewById(R.id.seekBarBlue);

		SetRed.setText(String.valueOf(SeekRed.getProgress()));
		SetGreen.setText(String.valueOf(SeekGreen.getProgress()));
		SetBlue.setText(String.valueOf(SeekBlue.getProgress()));

		TextView status = (TextView) findViewById(R.id.txtStatus);
		status.setText(String.valueOf(SetRed.getText()) + ','
				+ String.valueOf(SetGreen.getText()) + ','
				+ String.valueOf(SetBlue.getText()));
	}

	public void onClickEnableBt(View view) {
		// enable
		_bluetooth.enable();
		Intent enabler = new Intent(
				BluetoothAdapter.ACTION_REQUEST_DISCOVERABLE);
		startActivityForResult(enabler, REQUEST_DISCOVERABLE);
	}
	
	
	public void onClickFindBt(View view) {
		Intent enabler = new Intent(this, DiscoveryActivity.class);
		startActivity(enabler);
	}
	
	public void onClickDisableBt(View view) {
		// disable
		_bluetooth.disable();
	}	
}